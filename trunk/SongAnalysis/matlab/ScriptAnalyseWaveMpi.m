
% script MPI pour l'extraction de partition

%%% MPI_SEND est assez lent (3s pour 2e6 sample) (et 2.5 de calcul pour 1e6 sample),
%%% chaque thread va donc lire le fichier wave, ca ira plus vite


% Initialize MPI.
MPI_Init;

% Create communicator.
comm = MPI_COMM_WORLD;

% Get size and rank.
comm_size = MPI_Comm_size(comm);
my_rank = MPI_Comm_rank(comm);

% Print rank.
disp(['my_rank: ',num2str(my_rank)]);

% Set who is the leader
leader = 0;

% Create base message tags.
coefs_tag = 10000;
input_tag = 20000;
output_tag = 30000;

%%% Tout le monde calcul les constantes
constantes = AWinitConstantes();
%%%

global mpi_parameter_var;
% Leader.
if (my_rank == leader)
   
   %%% le leader recupere les parametres
  waverawdata = wavread(mpi_parameter_var.AWfilename); %y = wavread('filename',[N1 N2]) pour une portion du fichier
  % waverawdata= mpi_parameter_var.AWfilename;
   %%%

  % Broadcast le nom du fichier
  MPI_Bcast( leader, coefs_tag, comm, mpi_parameter_var.AWfilename );

  %%% calcul l'emplacement de toutes les fenêtres.
  len = size(waverawdata,1); %% tester
  fenetres = 1:441:len-constantes.lenF+1;
  nbfen = length(fenetres);
  nbfenpert = floor(nbfen/comm_size);
  nbrestefen = nbfen-comm_size*nbfenpert;
  
  output = zeros(1,length(fenetres));
      
  % Deal input data to everyone else including self.
  % envoie juste les fenêtres
  for i=1:comm_size
    dest_tag = input_tag + i;
    if(i==1)
        %fen_data = fenetres(1:nbfenpert+nbrestefen);
        dest_data = [1, fenetres(nbfenpert+nbrestefen) +constantes.lenF-1];
    else
        %fen_data = fenetres(nbfenpert*(i-1)+nbrestefen:nbfenpert*i+nbrestefen);
        dest_data = [fenetres(nbfenpert*(i-1)+nbrestefen); fenetres(nbfenpert*i+nbrestefen)+constantes.lenF-1];
    end
    
    MPI_Send(i-1,dest_tag,comm,dest_data);
  end
end

% Everyone but the leader receives the coefs.
if (my_rank ~= leader)
    % Receive coefs.
    AWfilename = MPI_Recv( leader, coefs_tag, comm );
end

% Everyone receives the input data and processes the results.
for i=1:comm_size
  % Compute who the destination is for this message.
  dest = i-1;

  % Check if this destination is me.
  if (my_rank == dest)
    % Compute tags.
    dest_tag = input_tag + i;
    leader_tag = output_tag + i;

    % Receive input.
    i_input =  MPI_Recv(leader,dest_tag,comm);

    % le leader à deja chargé le fichier wav
    if(my_rank~=leader)
        waverawdata = wavread(AWfilename,i_input);
    else
        waverawdata = waverawdata(i_input(1):i_input(2));
    end
    
    % Do computation.
    len = size(waverawdata,1);
    fenetres = 1:441:len-constantes.lenF;
    freqs = zeros(1,length(fenetres));
    for i=1:length(fenetres)
        freqs(i) = AWfindFreqF(waverawdata(fenetres(i):fenetres(i)+constantes.lenF-1,1)',constantes);
    end
    
    % Send results back to the leader.
    MPI_Send(leader,leader_tag,comm,freqs);
  end
end

% Leader receives all the results.
if (my_rank == leader)
    pos = 1;
  for i=1:comm_size
    % Compute who sent this message.
    dest = i-1;

    leader_tag = output_tag + i;

    % Receive output.
    temp =  MPI_Recv(dest,leader_tag,comm);
    
    % concatene les resultats
    output(pos:pos+length(temp)-1) = temp;
    pos=pos+length(temp);    
  end
  % fait la fin du traitement en monoproc, pas grave car comparativement très leger.
  [lfreq,duree] = AnalyseNote(output,constantes);
  tempo = AnalyseTempo(duree);
  mpi_parameter_var.AWres = ExtractPartition(lfreq,duree,tempo);
end

% mettre des clear?

% Finalize Matlab MPI.
MPI_Finalize;
disp('SUCCESS');
if (my_rank ~= MatMPI_Host_rank(comm))
  exit;
end

