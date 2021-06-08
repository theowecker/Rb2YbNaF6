%% spin wave analysis of Rb2YbNaF6
clc,close all

%generate lattice
rb2yb = spinw;
rb2yb.genlattice('lat_const',[8.895 8.895 8.895],'angled',[90 90 90],'spgr','F m -3 m')
%add Rb, Yb, Na, and F atoms to their positions on the lattice
rb2yb.addatom('label','Yb3+','r',[0; 0; 0],'S',1/2,'color','Blue');
rb2yb.addatom('label','Na','r',[1/2; 1/2; 1/2],'color','Yellow');
rb2yb.addatom('label','Rb','r',[.75; .25; .25],'color','Purple');
rb2yb.addatom('label','F','r',[1; .244; 0],'color','Gray');

rb2yb.gencoupling;

plot(rb2yb)

swplot.zoom(1)

%create polyhedra centered on Yb, Na, and Rb atoms
% swplot.plotchem('atom1','Yb3+','atom2','F','limit',6)
% swplot.plotchem('atom1','Na','atom2','F','limit',6,'replace',0)
% swplot.plotchem('atom1','Rb','atom2','F','limit',8,'replace',0)

%

%Heisenberg n.n. coupling J>0 AFM, J<0 FM
J=1.5;
%Kitaev exchange interaction
K=2;
%symmetry pseudodipole interaction which depends on bond orientation
F=3;


%select only the magnetic Yb atoms
rb2yb.unit_cell = rb2yb.unitcell(1);

%Heisenberg exchange term
 rb2yb.addmatrix('label','J1-','value',J,'mat_idx','J','color','gray');

%Kitaev exchange terms
rb2yb.addmatrix('label','Kx','value',diag([K 0 0]),'color','r');
rb2yb.addmatrix('label','-Kx','value',diag([-K 0 0]),'color','r');
rb2yb.addmatrix('label','Ky','value',diag([0 K 0]),'color','g');
rb2yb.addmatrix('label','-Ky','value',diag([0 -K 0]),'color','g');
rb2yb.addmatrix('label','Kz','value',diag([0 0 K]),'color','b');
rb2yb.addmatrix('label','-Kz','value',diag([0 0 -K]),'color','b');

%isotropic g tensor
% rb2yb.addmatrix('label','g0','value',1);
% rb2yb.addg('g0');


%add n.n. Heisenberg couplings
rb2yb.addcoupling('mat','J1-','mat_idx','J','bond',1);

%these Kitaev couplings correspond to the couplings from the Gang Chen paper 
%add +z and -z couplings
rb2yb.addcoupling('mat','Kz','bond',1,'subidx',[1 2]);
rb2yb.addcoupling('mat','-Kz','bond',1,'subidx',[5 6]);
%add +x and -x couplings
rb2yb.addcoupling('mat','Kx','bond',1,'subidx',[9 10]);
rb2yb.addcoupling('mat','-Kx','bond',1,'subidx',[13 14]);
%add +y and -y couplings
rb2yb.addcoupling('mat','Ky','bond',1,'subidx',[21 22]);
rb2yb.addcoupling('mat','-Ky','bond',1,'subidx',[17 18]);
%additional z Kitaev couplings needed?
rb2yb.addcoupling('mat','Kz','bond',1,'subidx',[3 4]);
rb2yb.addcoupling('mat','-Kz','bond',1,'subidx',[7 8]);
%additional y Kitaev couplings needed?
rb2yb.addcoupling('mat','Ky','bond',1,'subidx',[23 24]);
rb2yb.addcoupling('mat','-Ky','bond',1,'subidx',[19 20]);
%additional x Kitaev couplings needed?
rb2yb.addcoupling('mat','Kx','bond',1,'subidx',[11 12]);
rb2yb.addcoupling('mat','-Kx','bond',1,'subidx',[15 16]);

%plot couplings
% rb2yb.genmagstr('mode','helical','S',[1/2; 0; 0],'k',[1 2 0],'n',[0 0 1]);
% plot(rb2yb,'magColor','purple')
plot(rb2yb,'range',[1 1 1],'atomMode','mag','cellmode','inside','bondMode','line','bondLinewidth0',3,'bondLineWidth','lin','bondRadius1',0.2) %

rb2yb.table('bond',1:24);




