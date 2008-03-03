
% lance l'extraction de partition sur plusieurs processeur
% utilise la variable globale mpi_parameter_var pour passer les paramêtres
function res = AnalyseWaveMPI(filename)
    global mpi_parameter_var;
    
    mpi_parameter_var.AWfilename = filename;
    
    MatMPI_Delete_all;
    eval( MPI_Run('ScriptAnalyseWaveMpi',     2,{}) );

    res = mpi_parameter_var.AWres;
