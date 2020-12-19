function output = my_edge(input_image,method)
%in this function, you should finish the edge detection utility.
%the input parameter is a matrix of a gray image
%the output parameter is a matrix contains the edge index using 0 and 1
%the entries with 1 in the matrix shows that point is on the edge of the
%image
%you can use different methods to complete the edge detection function
%the better the final result and the more methods you have used, you will get higher scores  



if method==1
    %base method when method == 1
    %step1 smoothing by gaussian filter
    [M,N]=size(input_image);
    sigm=1.4;
    n=9;
    gauss_filter=fspecial('gaussian',[n n],sigm);  
    tmp=imfilter(input_image,gauss_filter,'replicate');  
   
    %step2 sobel filter to get gradient,then |gx|+|gy|
    Sobel_filterX =[[-1 -2 -1];[0 0 0];[1 2 1]];
    Sobel_filterY=[[-1 0 1];[-2 0 2];[-1 0 1]];
    gradX=imfilter(tmp,Sobel_filterX,'replicate');
    gradY=imfilter(tmp,Sobel_filterY,'replicate');
    tmp=abs(gradX)+abs(gradY);
    
    %step3 threshold
    tmp2=zeros(M,N);
    Max=max(max(tmp));
    Min=min(min(tmp));
    threshold=(Max-Min)*0.3;

    for i=1:M
        for j=1:N
            if tmp(i,j)>threshold+Min
                tmp2(i,j)=255;
            else
                tmp2(i,j)=0;
            end
        end
    end

    output=tmp2;

elseif method==2
    % marr-Hildreth when method==2
    %step1 smoothing by gaussian filter
    [M,N]=size(input_image);
    sigm=1.4;
    n=9;
    gauss_filter=fspecial('gaussian',[n n],sigm);  
    tmp=imfilter(input_image,gauss_filter,'replicate');  

    %step2 laplacian filter
    laplacian_filter =ones(3,3);
    laplacian_filter(2,2)=-8;
    tmp=imfilter(tmp,laplacian_filter,'replicate');  
    
    %step3 threshold
    tmp2=zeros(M,N);
    Max=max(max(tmp));
    Min=min(min(tmp));

    %改进的写法寻找零交叉
    threshold=(Max-Min)*0.45;
    for i=2:M-1
        for j=2:N-1
            p(1)=sum(sum(tmp(i-1:i,j-1:j)));
            p(2)=sum(sum(tmp(i-1:i,j:j+1)));
            p(3)=sum(sum(tmp(i:i+1,j-1:j)));
            p(4)=sum(sum(tmp(i:i+1,j:j+1)));
            max_p=max(p);
            min_p=min(p);
            deta_p=max_p-min_p;
            if max_p>0 && min_p<0&&deta_p>threshold
                tmp2(i,j)=255;
            else
                tmp2(i,j)=0;
            end
        end
    end

% %   原本寻找零交叉的写法
%     threshold=(Max-Min)*0.2;
%     for i=2:M-1
%         for j=2:N-1
% 
%             if tmp(i-1,j)*tmp(i+1,j)<0 && abs(tmp(i-1,j)-tmp(i+1,j))>threshold
%                 tmp2(i,j)=255;
%             elseif tmp(i,j-1)*tmp(i,j+1)<0 && abs(tmp(i,j-1)-tmp(i,j+1))>threshold
%                 tmp2(i,j)=255;
%             elseif tmp(i-1,j-1)*tmp(i+1,j+1)<0 && abs(tmp(i-1,j-1)-tmp(i+1,j+1))>threshold
%                 tmp2(i,j)=255;
%             elseif tmp(i+1,j-1)*tmp(i-1,j+1)<0 && abs(tmp(i+1,j-1)-tmp(i-1,j+1))>threshold
%                 tmp2(i,j)=255;                
%             else
%                 tmp2(i,j)=0;
%             end
%         end
%     end
    
    output=tmp2;

else
    %canny when method== else
    
    %step1 smoothing by gaussian filter
    [M,N]=size(input_image);
    sigm=1.4;
    n=9;
    gauss_filter=fspecial('gaussian',[n n],sigm);  
    tmp=imfilter(input_image,gauss_filter,'replicate');  
    
    %step2 sobel filter to get gradient,then sqrt(|gx|^2+|gy|^2) and cot(gy/gx)
    Sobel_filterX =[[-1 -2 -1];[0 0 0];[1 2 1]];
    Sobel_filterY=[[-1 0 1];[-2 0 2];[-1 0 1]];
    gradX=imfilter(tmp,Sobel_filterX,'replicate');
    gradY=imfilter(tmp,Sobel_filterY,'replicate');
    gradValue=sqrt((gradX.*gradX)+(gradY.*gradY));
    gradDir=atan(gradY./gradX);
    
    %step3 not maximum suppresion
    tmp2=zeros(M,N);
    for i=2:M-1
        for j=2:N-1
            tag=1;%水平边缘，梯度方向竖着
            if abs(gradDir(i,j))>pi*67.5/180
                tag=2 ;%垂直边缘，梯度方向横着
            elseif gradDir(i,j)>pi*22.5/180
                tag=3 ;%梯度方向左上右下
            elseif gradDir(i,j)<-1*pi*22.5/180
                tag=4 ; %梯度方向左下到右上
            end
            if tag==1
                if gradValue(i,j)>=gradValue(i-1,j)&&gradValue(i,j)>=gradValue(i+1,j)
                    tmp2(i,j)=gradValue(i,j);
                end
            elseif tag==2
                if gradValue(i,j)>=gradValue(i,j-1)&&gradValue(i,j)>=gradValue(i,j+1)
                    tmp2(i,j)=gradValue(i,j);
                end
            elseif tag==3
                if gradValue(i,j)>=gradValue(i-1,j-1)&&gradValue(i,j)>=gradValue(i+1,j+1)
                    tmp2(i,j)=gradValue(i,j);
                end
            else
                if gradValue(i,j)>=gradValue(i+1,j-1)&&gradValue(i,j)>=gradValue(i-1,j+1)
                    tmp2(i,j)=gradValue(i,j);
                end
            end
            
        end
    end
    
    
    %step4 dual threshold 
    ma=max(max(tmp2));
    threL=0.1*ma;
    threH=0.2*ma;
    NH=zeros(M,N);
    NL=zeros(M,N);
    for i=1:M
    for j=1:N
        if tmp2(i,j)>threH
            NH(i,j)=255;
        elseif tmp2(i,j)>threL
            NL(i,j)=255;
        end
    end
    end
    
    %step5 check connection
    for i=2:M-1
    for j=2:N-1
        if NL(i,j)==255 && sum(sum(NH(i-1:i+1,j-1:j+1)))==0
            NL(i,j)=0;
        end
    end
    end
    
    for i=1:M-1
        if NL(i,1)==255 && sum(sum(NH(i:i+1,1:2)))==0
            NL(i,1)=0;
        end
        if NL(i,N)==255 && sum(sum(NH(i:i+1,N-1:N)))==0
            NL(i,N)=0;
        end
    end
    
    if NL(M,1)==255 && sum(sum(NH(M-1:M,1:2)))==0
        NL(M,1)=0;
    end
    
    if NL(M,N)==255 && sum(sum(NH(M-1:M,N-1:N)))==0
        NL(M,N)=0;
    end
    %matlab内置库，可以参考效果
    %output=edge(tmp2,'canny',[0.1,0.2]);
    output=NH+NL;
end
end
