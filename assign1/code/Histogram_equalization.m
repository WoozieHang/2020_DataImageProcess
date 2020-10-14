function [output] = Histogram_equalization(input_image,method)
%first test the image is a RGB or gray image
if numel(size(input_image)) == 3
    %this is a RGB image
    %here is just one method, if you have other ways to do the
    %equalization, you can change the following code
    if method==0
       [output]=input_image;
    elseif method==1
        %   默认方法,rgb信道独立处理再合并,效果一般，会出现颜色失调的现象
        r=input_image(:,:,1);
        v=input_image(:,:,2);
        b=input_image(:,:,3);
        r1 = hist_equal(r);
        v1 = hist_equal(v);
        b1 = hist_equal(b);
        [output] = cat(3,r1,v1,b1);   
    
    
    elseif method==2
        %平均rgb再均匀化,对均值rgb处理，然后根据比例系数还原rgb，效果和hsi类似
        r=input_image(:,:,1);
        g=input_image(:,:,2);
        b=input_image(:,:,3);
        r=im2double(r);
        g=im2double(g);
        b=im2double(b);
    
        v=(r+g+b)/3;
    
        [ROW,COL]=size(r);
        for ii=1:ROW
            for jj=1:COL
                r(ii,jj)=r(ii,jj)/v(ii,jj);
                g(ii,jj)=g(ii,jj)/v(ii,jj);
                b(ii,jj)=b(ii,jj)/v(ii,jj);
            end
        end
        v=im2double(hist_equal(uint8(255*v)));
    
        for ii=1:ROW
            for jj=1:COL
                r(ii,jj)=r(ii,jj)*v(ii,jj);
                g(ii,jj)=g(ii,jj)*v(ii,jj);
                b(ii,jj)=b(ii,jj)*v(ii,jj);
            end
        end
    
        r=uint8(r*255);
        g=uint8(g*255);
        b=uint8(b*255);
        [output] = cat(3,r,g,b);   
    
    elseif method==3
        % 转成hsi的思路,单独对强度分类i处理，效果还行
        [hsi]=rgb2hsi(input_image);
        H = hsi(:, :, 1); 
        S = hsi(:, :, 2); 
        I = hsi(:, :, 3);
        I2=im2double(hist_equal(uint8(255*I)));
        hsi2=cat(3,H,S,I2);
        ans1=uint8(255*hsi2rgb(hsi2));
        t1=ans1(:, :,1);
        t2=ans1(:, :,2);
        t3=ans1(:, :,3);
        [output]=cat(3,t1,t2,t3);
    
    elseif method==4
        %   YCbCr法    单独对转换后的Y分量处理，效果在所有中最好
        r=im2double(input_image(:,:,1));
        g=im2double(input_image(:,:,2));
        b=im2double(input_image(:,:,3));
        %转成YCbCr

        Y=0.299*r+0.587*g+0.114*b;
        cb=-0.169*r-0.331*g+0.5*b;
        cr=0.5*r-0.419*g-0.081*b;
        Y1=uint8(255*Y);
        Y2=hist_equal(Y1);
        Y3=im2double(Y2);
        %再转换回rgb
        r1=Y3+1.403*cr;
        g1=Y3-0.344*cb-0.714*cr;
        b1=Y3+1.773*cb;
        r2=uint8(255*r1);
        g2=uint8(255*g1);
        b2=uint8(255*b1);
        [output] = cat(3,r2,g2,b2);    
    else
         [output]=histeq(input_image);
    end
    
else
    %this is a gray image
    if method==0
       [output]=input_image;
    elseif method==1||method==2||method==3||method==4
        [output] = hist_equal(input_image);
    else
        [output]=histeq(input_image);
    end
end

    function [output2] = hist_equal(input_channel)
    %you should complete this sub-function
    [M,N]=size(input_channel);
    map=zeros(256,1);
    for i=1:M
        for j=1:N
            grey_value=input_channel(i,j);
            map(grey_value+1,1)=map(grey_value+1,1)+1;
        end
    end
    sum=0;
    for k=1:256
        sum=sum+map(k,1);
        map(k,1)=sum;
    end
    num=M*N;
    for k=1:256
        map(k,1)=uint8(255*map(k,1)/(num));
    end
    output2=input_channel;
    for i=1:M
        for j=1:N
            output2(i,j)=map(output2(i,j)+1,1);
        end
    end
  
    end
end