function [Gb] = GeneticAlgorithm(nearEnd, farEnd)
nn=size(nearEnd, 1); % number of straight paths
ps=3000; % population size
ng=5000; % number of generation
pm=0.01; % probability of mutation of exchange 2 random cities in the path (per gene, per genration)
pm2=0.02; % probability of mutation of exchange 2 pieces of path (per gene, per genration)
pmf=0.08; % probability of mutation of flip random piece of path

% start from random closed pathes:
G=zeros(ps,nn); % genes, G(i,:) - gene of i-path, G(i,:) is row-vector with cities number in the path
for psc=1:ps
    G(psc,:)=randperm(nn);
end

pthd=zeros(ps,1); %path lengths
p=zeros(ps,1); % probabilities
for gc=1:ng % generations loop
    % find paths length:
    for psc=1:ps
        Gt=G(psc,:);
        pt=PathEnergy(nearEnd, farEnd, Gt);
        pthd(psc)=pt;
    end
    ipthd=1./pthd; % inverse path energy, we want to maximize inverse path length
    p=ipthd/sum(ipthd); % probabilities
    
    [~, bp]=max(p); 
    Gb=G(bp,:); % best path 
    
    % crossover:
    ii=roulette_wheel_indexes(ps,p); % genes with cities numbers in ii will be put to crossover
    % length(ii)=ps, then more probability p(i) of i-gene then more
    % frequently it repeated in ii list
    Gc=G(ii,:); % genes to crossover
    Gch=zeros(ps,nn); % childrens
    for prc=1:(ps/2) % pairs counting
        i1=1+2*(prc-1);
        i2=2+2*(prc-1);
        g1=Gc(i1,:); %one gene
        g2=Gc(i2,:); %another gene
        cp=ceil((nn-1)*rand); % crossover point, random number form range [1; nn-1]
        
      
        % two childrens:
        g1ch=insert_begining_slow(g1,g2,cp);
        g2ch=insert_begining_slow(g2,g1,cp);
        Gch(i1,:)=g1ch;
        Gch(i2,:)=g2ch;
    end
    G=Gch; % now children
    
    
    % mutation of exchange 2 random cities:
    for psc=1:ps
        if rand<pm
            rnp=ceil(nn*rand); % random number of sicies to permuation
            rpnn=randperm(nn);
            ctp=rpnn(1:rnp); %chose rnp random cities to permutation
            Gt=G(psc,ctp); % get this cites from the list
            Gt=Gt(randperm(rnp)); % permutate cities
            G(psc,ctp)=Gt; % % return cities back
         end
    end
    
    % mutation of exchange 2 pieces of path:
    for psc=1:ps
        if rand<pm2
            cp=1+ceil((nn-3)*rand); % range [2 nn-2]
            G(psc,:)=[G(psc,cp+1:nn) G(psc,1:cp)];
        end
    end
    
    % mutation of flip randm pece of path:
    for psc=1:ps
        if rand<pmf
            n1=ceil(nn*rand);
            n2=ceil(nn*rand);
            G(psc,n1:n2)=fliplr(G(psc,n1:n2));
        end
    end
            
    G(1,:)=Gb; % elitism   
        
end
