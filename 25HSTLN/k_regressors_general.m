function labels=k_regressors_general(W,d,k);

[Nf,Np]=size(W);
Nf=Nf/d;

for(ftr=1:d)
X(ftr).data=W(ftr:d:end,:);
end


order=10;


regressors=zeros(d*d*order+d,k);
order=order+1;

%%%regressor initialization
best_error=1000000000000;
for(best=1:10)

    current_labels=randint(1,Np,[1 k]); %%%randomly assign points to different regressors
    
%     randomizer=rand(1,Np);
%     [dummy indx]=sort(randomizer);
%     current_labels(indx(1:k-1))=1:k-1;
%     current_labels(indx(k:end))=k;
        
        
    
    
    last_labels=0*current_labels;
    iterr=0;
    Mind=hankel(1:Nf-order+1,Nf-order+1:Nf);
    while(sum(abs(last_labels-current_labels))>0.1 & iterr<100)
        iterr=iterr+1;
        for(reg=1:k)
            
            A1=[];
            b=[];
            for(ftr=1:d)
                X_in(ftr).data=X(ftr).data(:,current_labels==reg);
                points_in=size(X_in(ftr).data,2);
                X_prev(ftr).data=zeros(points_in*((Nf-(order)+1)),order);
                ttt=kron(ones(points_in,1),[ones(Nf-order+1,1); zeros(order-1,1)]);
                XX(ftr).data=X_in(ftr).data(:);
                
                if(points_in~=0)
                    Mindh=hankel(1:points_in*Nf,[points_in*Nf ones(1,order-1)]);
                    Mindh=Mindh(logical(ttt),:);
                    X_prev(ftr).data=XX(ftr).data(Mindh);
                    A1=[A1 X_prev(ftr).data(:,1:end-1)];
                    b=[b; X_prev(ftr).data(:,end)];
                else
                    A1=[];
                    b=[];
                end
       
            end
            A1=[A1 ones(size(X_prev(1).data,1),1)];
            A=kron(eye(d),A1);
            
            if(~isempty(b))
            regressors(:,reg)=A\b;
            else
                regressors(:,reg)=0;
            end
                
        end

        last_labels=current_labels;
        %update labels using the found regressors

        for(p=1:Np)


            lowest_error=1000000000000;
            A1=[];
            b=[];
            X_prev=[];
            for(ftr=1:d)
                xp(ftr).data=X(ftr).data(:,p);
                X_prev(ftr).data=zeros(1*((Nf-(order)+1)),order);
                X_prev(ftr).data(1:(Nf-order+1),:)=xp(ftr).data(Mind);
                A1=[A1 X_prev(ftr).data(:,1:end-1)];
                b=[b; X_prev(ftr).data(:,end)];
            end
            A1=[A1 ones(size(X_prev(1).data,1),1)];
            A=kron(eye(d),A1);
           
            for(reg=1:k)
                current_error=norm(A*regressors(:,reg)-b);
                if(current_error<lowest_error)
                    lowest_error=current_error;
                    current_labels(p)=reg;
                end
            end

        end

        55;

    end


    end_error=0;
    X_prev=[];
    A1=[];
    b=[];
    for(p=1:Np)
        A1=[];
        b=[];
        for(ftr=1:d)
            xp(ftr).data=X(ftr).data(:,p);
            X_prev(ftr).data=zeros(1*((Nf-(order)+1)),order);
            X_prev(ftr).data(1:(Nf-order+1),:)=xp(ftr).data(Mind);
            A1=[A1 X_prev(ftr).data(:,1:end-1)];
            b=[b; X_prev(ftr).data(:,end)];
        end
        A1=[A1 ones(size(X_prev(1).data,1),1)];
        A=kron(eye(d),A1);
        current_error=norm(A*regressors(:,current_labels(p))-b);
        end_error=end_error+current_error;
    end

    55;
    if(end_error<best_error)
        best_error=end_error;
        labels=current_labels;
    end


end

best_error






