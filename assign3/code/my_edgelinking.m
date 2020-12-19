function output = my_edgelinking(binary_image, row, col)
%in this function, you should finish the edge linking utility.
%the input parameters are a matrix of a binary image containing the edge
%information and coordinates of one of the edge points of a obeject
%boundary, you should run this function multiple times to find different
%object boundaries
%the output parameter is a Q-by-2 matrix, where Q is the number of boundary 
%pixels. B holds the row and column coordinates of the boundary pixels.
%you can use different methods to complete the edge linking function
%the better the quality of object boundary and the more the object boundaries, you will get higher scores
 
%get gradient,then sqrt(|gx|^2+|gy|^2) and cot(gy/gx)
    if binary_image(row,col)==255
        [M,N]=size(binary_image);
        
        %加入第一个点
        output(1,1)=row;
        output(1,2)=col;
        num=1;
        
        track=zeros(M,N);%用于记录已经加入的边界点
        
%         Sobel_filterX =[[-1 -2 -1];[0 0 0];[1 2 1]];
%         Sobel_filterY=[[-1 0 1];[-2 0 2];[-1 0 1]];
%         gradX=imfilter(binary_image,Sobel_filterX,'replicate');
%         gradY=imfilter(binary_image,Sobel_filterY,'replicate');
%         gradValue=sqrt((gradX.*gradX)+(gradY.*gradY));
%         gradDir=atan(gradY./gradX);
        
        %定位当前的位置
        id_r=row;
        id_c=col;
        %track(row,col)=255;
        
        find_next=0;
        
        while 1>0
            %当前在非边界处
           if(id_r>1 && id_r<M && id_c>1 && id_c<N)
                for i=-1:1
                    for j=-1:1
                        if(binary_image(id_r+i,id_c+j)>0 && track(id_r+i,id_c+j)==0)
                            find_next=1;
                            id_r=id_r+i;
                            id_c=id_c+j;
                            track(id_r,id_c)=255;
                            num=num+1;
                            output(num,1)=id_r;
                            output(num,2)=id_c;
                            break;
                        end
                    end
                    if(find_next)
                        break;
                    end
                end
                
            %当前在上边界处
           elseif(id_r==1&& id_c>1 && id_c<N)
                for i=0:1
                    for j=-1:1
                        if(binary_image(id_r+i,id_c+j)>0 && track(id_r+i,id_c+j)==0)
                            find_next=1;
                            id_r=id_r+i;
                            id_c=id_c+j;
                            track(id_r,id_c)=255;
                            num=num+1;
                            output(num,1)=id_r;
                            output(num,2)=id_c;                            
                            break;
                        end
                    end
                    if(find_next)
                        break;
                    end
                end

           
           %当前在下边界处
           elseif(id_r==M && id_c>1 && id_c<N)
                for i=-1:0
                    for j=-1:1
                        if(binary_image(id_r+i,id_c+j)>0 && track(id_r+i,id_c+j)==0)
                            find_next=1;
                            id_r=id_r+i;
                            id_c=id_c+j;
                            track(id_r,id_c)=255;
                            num=num+1;
                            output(num,1)=id_r;
                            output(num,2)=id_c;                            
                            break;
                        end
                    end
                    if(find_next)
                        break;
                    end
                end

           
           %当前在左边界处
           elseif(id_c==0&& id_r>1 && id_r<M)
                for i=-1:1
                    for j=0:1
                        if(binary_image(id_r+i,id_c+j)>0 && track(id_r+i,id_c+j)==0)
                            find_next=1;
                            id_r=id_r+i;
                            id_c=id_c+j;
                            track(id_r,id_c)=255;
                            num=num+1;
                            output(num,1)=id_r;
                            output(num,2)=id_c;
                            break;
                        end
                    end
                    if(find_next)
                        break;
                    end
                end
           
           %当前在右边界处
           elseif(id_c==N&& id_r>1 && id_r<M)
                for i=-1:1
                    for j=-1:0
                        if(binary_image(id_r+i,id_c+j)>0 && track(id_r+i,id_c+j)==0)
                            find_next=1;
                            id_r=id_r+i;
                            id_c=id_c+j;
                            track(id_r,id_c)=255;
                            num=num+1;
                            output(num,1)=id_r;
                            output(num,2)=id_c;                            
                            break;
                        end
                    end
                    if(find_next)
                        break;
                    end
                end
           
           %当前在左上角
           elseif(id_r==1&&id_c==1)
                for i=0:1
                    for j=0:1
                        if(binary_image(id_r+i,id_c+j)>0 && track(id_r+i,id_c+j)==0)
                            find_next=1;
                            id_r=id_r+i;
                            id_c=id_c+j;
                            track(id_r,id_c)=255;
                            num=num+1;
                            output(num,1)=id_r;
                            output(num,2)=id_c;                            
                            break;
                        end
                    end
                    if(find_next)
                        break;
                    end
                end
                
           %当前在左下角
           elseif(id_r==M&&id_c==1)
                for i=-1:0
                    for j=0:1
                        if(binary_image(id_r+i,id_c+j)>0 && track(id_r+i,id_c+j)==0)
                            find_next=1;
                            id_r=id_r+i;
                            id_c=id_c+j;
                            track(id_r,id_c)=255;
                            num=num+1;
                            output(num,1)=id_r;
                            output(num,2)=id_c;                            
                            break;
                        end
                    end
                    if(find_next)
                        break;
                    end
                end
           
           %当前在右上角
           elseif(id_r==1&&id_c==N)
                for i=0:1
                    for j=-1:0
                        if(binary_image(id_r+i,id_c+j)>0 && track(id_r+i,id_c+j)==0)
                            find_next=1;
                            id_r=id_r+i;
                            id_c=id_c+j;
                            track(id_r,id_c)=255;
                            num=num+1;
                            output(num,1)=id_r;
                            output(num,2)=id_c;                            
                            break;
                        end
                    end
                    if(find_next)
                        break;
                    end
                end
           
           %当前在右下角
           elseif(id_r==M&&id_c==N)
                for i=-1:0
                    for j=-1:0
                        if(binary_image(id_r+i,id_c+j)>0 && track(id_r+i,id_c+j)==0)
                            find_next=1;
                            id_r=id_r+i;
                            id_c=id_c+j;
                            track(id_r,id_c)=255;
                            num=num+1;
                            output(num,1)=id_r;
                            output(num,2)=id_c;                            
                            break;
                        end
                    end
                    if(find_next)
                        break;
                    end
                end                
                
           end
           
          
           
           
           if find_next==0
              break;
           else
               find_next=0;
           end
        end
        
%         output(num+1,1)=row;
%         output(num+1,2)=col;       
    end


    
    
