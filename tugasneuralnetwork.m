%Input    
    x1=0.05;
    x2=0.10;
    b1=0.35;
    b2=0.60;
    w1=0.15;
    w2=0.20;
    w3=0.25;
    w4=0.30;
    w5=0.40;
    w6=0.45;
    w7=0.50;
    w8=0.55;
    t1=0.01;
    t2=0.99;
    lr=0.5;
    masiherror=false;
    galat=0.28;

%Forward Pass
    h1=(x1*w1)+(x2*w2)+b1;
    outh1=1/(1+exp(-h1));
	
    h2=(x1*w3)+(x2*w4)+b1;
    outh2=1/(1+exp(-h2));

    y1=(outh1*w5)+(outh2*w6)+b2;
    outy1=1/(1+exp(-y1));
	
    y2=(outh1*w7)+(outh2*w8)+b2;
    outy2=1/(1+exp(-y2));

%Total Error
    E1=0.5*((t1-outy1)^2);
    E2=0.5*((t2-outy2)^2);
    Etot=E1+E2;

lamaw1tow8=[w1 w2 w3 w4 w5 w6 w7 w8];
lamah1h2outh1outh2=[h1 h2 outh1 outh2];
lamay1y2outy1outy2=[y1 y2 outy1 outy2];
lamaE1E2Etot=[E1 E2 Etot];

%Update w5
    %Langkah 1
        dE1perdouty1=outy1-t1;
    %Langkah 2
        douty1perdy1=outy1*(1-outy1);
    %Langkah 3
        dy1perdw5=outh1;
    %Hasil dE1 / dw5
        dE1perdw5=dE1perdouty1*douty1perdy1*dy1perdw5;

%Update W6	
    %Langkah 1
        dE1perdouty1=outy1-t1;
    %Langkah 2
        douty1perdy1=outy1*(1-outy1);
    %Langkah 3
        dy1perdw6=outh2;
    %Hasil dE1 / dw6
        dE1perdw6=dE1perdouty1*douty1perdy1*dy1perdw6;
        
%Update W7	
    %Langkah 1
        dE2perdouty2=outy2-t2;
    %Langkah 2
        douty2perdy2=outy2*(1-outy2);
    %Langkah 3
        dy2perdw7=outh1;
    %Hasil dE2 / dw7
        dE2perdw7=dE2perdouty2*douty2perdy2*dy2perdw7;
        
%Update W8	
    %Langkah 1
        dE2perdouty2=outy2-t2;
    %Langkah 2
        douty2perdy2=outy2*(1-outy2);
    %Langkah 3
        dy2perdw8=outh2;
    %Hasil dE2 / dw8
        dE2perdw8=dE2perdouty2*douty2perdy2*dy2perdw8;
        
lamaw5w6w7w8=[dE1perdouty1 douty1perdy1 dy1perdw5 dE1perdw5 dy1perdw6 dE1perdw6 dE2perdouty2 douty2perdy2 dy2perdw7 dE2perdw7 dy2perdw8 dE2perdw8]; 
        
%Update W1
    %Langkah 1		
        %Langkah 1.1
            dy1perdouth1=w5;
            dE1perdy1=dE1perdouty1*douty1perdy1;
            dE1perdouth1=dE1perdy1*dy1perdouth1;
        %Langkah 1.2
            dy2perdouth2=w8;
            dE2perdy2=dE2perdouty2*douty2perdy2;
            dE2perdouth2=dE2perdy2*dy2perdouth2;
        dEtotperdouth1=dE1perdouth1+dE2perdouth2;
    %Langkah 2
        douth1perdh1=outh1*(1-outh1);
    %Langkah 3	
        dh1perdw1=x1;
    %Hasil dEtot / dw1
        dEtotperdw1=dEtotperdouth1*douth1perdh1*dh1perdw1;

%Update W2	
    %Langkah 1
        %Langkah 1.1
            dE1perdy1=dE1perdouty1*douty1perdy1;
            dE1perdouth1=dE1perdy1*dy1perdouth1;
        %Langkah 1.2
            dE2perdy2=dE2perdouty2*douty2perdy2;
            dE2perdouth2=dE2perdy2*dy2perdouth2;
        dEtotperdouth1=dE1perdouth1+dE2perdouth2;
    %Langkah 2
        douth1perdh1=outh1*(1-outh1);
    %Langkah 3
        dh1perdw2=x2;
    %Hasil dEtot / dw1
        dEtotperdw2=dEtotperdouth1*douth1perdh1*dh1perdw2;
        
%Update W3
    %Langkah 1		
        %Langkah 1.1
            dy1perdouth2=w6;
            dE1perdy1=dE1perdouty1*douty1perdy1;
            dE1perdouth2=dE1perdy1*dy1perdouth2;
        %Langkah 1.2
            dy2perdouth1=w7;
            dE2perdy2=dE2perdouty2*douty2perdy2;
            dE2perdouth1=dE2perdy2*dy2perdouth1;
        dEtotperdouth2=dE1perdouth2+dE2perdouth1;
    %Langkah 2 
        douth2perdh2=outh2*(1-outh2);
    %Langkah 3	
        dh2perdw3=x1;
    %hasil dEtot / dw3
        dEtotperdw3=dEtotperdouth2*douth2perdh2*dh2perdw3;
        
%Update W4
    %Langkah 1	
        %Langkah 1.1
            dE1perdy1=dE1perdouty1*douty1perdy1;
            dE1perdouth2=dE1perdy1*dy1perdouth2;
        %Langkah 1.2
            dE2perdy2=dE2perdouty2*douty2perdy2;
            dE2perdouth1=dE2perdy2*dy2perdouth1;
        dEtotperdouth2=dE1perdouth2+dE2perdouth1;
    %Langkah 2 
        douth2perdh2=outh2*(1-outh2);
    %Langkah 3	
        dh2perdw4=x2;
    %Hasil dEtot / dw3
        dEtotperdw4=dEtotperdouth2*douth2perdh2*dh2perdw4;
        
lamaw1w2w3w4=[dE1perdy1 dE1perdouth1 dE2perdy2 dE2perdouth2 dEtotperdouth1 douth1perdh1 dh1perdw1 dEtotperdw1 dh1perdw2 dEtotperdw2 dE1perdouth2 dE2perdouth1 dEtotperdouth2 douth2perdh2 dh2perdw3 dEtotperdw3 dh2perdw4 dEtotperdw4];
    
while Etot>=galat
    if masiherror==true
        %Forward Pass
            h1=(x1*w1)+(x2*w2)+b1;
            outh1=1/(1+exp(-h1));
	
            h2=(x1*w3)+(x2*w4)+b1;
            outh2=1/(1+exp(-h2));

            y1=(outh1*w5)+(outh2*w6)+b2;
            outy1=1/(1+exp(-y1));

            y2=(outh1*w7)+(outh2*w8)+b2;
            outy2=1/(1+exp(-y2));

        %Total Error
            E1=0.5*((t1-outy1)^2);
            E2=0.5*((t2-outy2)^2);
            Etot=E1+E2;
            
        baruh1h2outh1outh2=[h1 h2 outh1 outh2];
        baruy1y2outy1outy2=[y1 y2 outy1 outy2];
        baruE1E2Etot=[E1 E2 Etot];    
        
        gabungh1h2outh1outh2=[lamah1h2outh1outh2; baruh1h2outh1outh2];
        gabungy1y2outy1outy2=[lamay1y2outy1outy2; baruy1y2outy1outy2];
        gabungE1E2Etot=[lamaE1E2Etot; baruE1E2Etot];
        
        lamah1h2outh1outh2=gabungh1h2outh1outh2;
        lamay1y2outy1outy2=gabungy1y2outy1outy2;
        lamaE1E2Etot=gabungE1E2Etot;
        
        %Update w5
            %Langkah 1
                dE1perdouty1=outy1-t1;
            %Langkah 2
                douty1perdy1=outy1*(1-outy1);
            %Langkah 3
                dy1perdw5=outh1;
            %Hasil dE1 / dw5
                dE1perdw5=dE1perdouty1*douty1perdy1*dy1perdw5;

        %Update W6	
            %Langkah 1
                dE1perdouty1=outy1-t1;
            %Langkah 2
                douty1perdy1=outy1*(1-outy1);
            %Langkah 3
                dy1perdw6=outh2;
            %Hasil dE1 / dw6
                dE1perdw6=dE1perdouty1*douty1perdy1*dy1perdw6;      
                
        %Update W7	
            %Langkah 1
                dE2perdouty2=outy2-t2;
            %Langkah 2
                douty2perdy2=outy2*(1-outy2);
            %Langkah 3
                dy2perdw7=outh1;
            %Hasil dE2 / dw7
                dE2perdw7=dE2perdouty2*douty2perdy2*dy2perdw7;

        %Update W8	
            %Langkah 1
                dE2perdouty2=outy2-t2;
            %Langkah 2
                douty2perdy2=outy2*(1-outy2);
            %Langkah 3
                dy2perdw8=outh2;
            %Hasil dE2 / dw8
                dE2perdw8=dE2perdouty2*douty2perdy2*dy2perdw8;
        
        baruw5w6w7w8=[dE1perdouty1 douty1perdy1 dy1perdw5 dE1perdw5 dy1perdw6 dE1perdw6 dE2perdouty2 douty2perdy2 dy2perdw7 dE2perdw7 dy2perdw8 dE2perdw8];
        
        gabungw5w6w7w8=[lamaw5w6w7w8; baruw5w6w7w8];
        
        lamaw5w6w7w8=gabungw5w6w7w8;
        
        %Update W1
            %Langkah 1		
                %Langkah 1.1
                    dy1perdouth1=w5;
                    dE1perdy1=dE1perdouty1*douty1perdy1;
                    dE1perdouth1=dE1perdy1*dy1perdouth1;
                %Langkah 1.2
                    dy2perdouth2=w8;
                    dE2perdy2=dE2perdouty2*douty2perdy2;
                    dE2perdouth2=dE2perdy2*dy2perdouth2;
                dEtotperdouth1=dE1perdouth1+dE2perdouth2;
            %Langkah 2
                douth1perdh1=outh1*(1-outh1);
            %Langkah 3	
                dh1perdw1=x1;
            %Hasil dEtot / dw1
                dEtotperdw1=dEtotperdouth1*douth1perdh1*dh1perdw1;

        %Update W2	
            %Langkah 1
                %Langkah 1.1
                    dE1perdy1=dE1perdouty1*douty1perdy1;
                    dE1perdouth1=dE1perdy1*dy1perdouth1;
                %Langkah 1.2
                    dE2perdy2=dE2perdouty2*douty2perdy2;
                    dE2perdouth2=dE2perdy2*dy2perdouth2;
                dEtotperdouth1=dE1perdouth1+dE2perdouth2;
            %Langkah 2
                douth1perdh1=outh1*(1-outh1);
            %Langkah 3
                dh1perdw2=x2;
            %Hasil dEtot / dw1
                dEtotperdw2=dEtotperdouth1*douth1perdh1*dh1perdw2;
        
        %Update W3
            %Langkah 1		
                %Langkah 1.1
                    dy1perdouth2=w6;
                    dE1perdy1=dE1perdouty1*douty1perdy1;
                    dE1perdouth2=dE1perdy1*dy1perdouth2;
                %Langkah 1.2
                    dy2perdouth1=w7;
                    dE2perdy2=dE2perdouty2*douty2perdy2;
                    dE2perdouth1=dE2perdy2*dy2perdouth1;
                dEtotperdouth2=dE1perdouth2+dE2perdouth1;
            %Langkah 2 
                douth2perdh2=outh2*(1-outh2);
            %Langkah 3	
                dh2perdw3=x1;
            %hasil dEtot / dw3
                dEtotperdw3=dEtotperdouth2*douth2perdh2*dh2perdw3;

        %Update W4
            %Langkah 1	
                %Langkah 1.1
                    dE1perdy1=dE1perdouty1*douty1perdy1;
                        dE1perdouth2=dE1perdy1*dy1perdouth2;
                    %Langkah 1.2
                        dE2perdy2=dE2perdouty2*douty2perdy2;
                        dE2perdouth1=dE2perdy2*dy2perdouth1;
                dEtotperdouth2=dE1perdouth2+dE2perdouth1;
            %Langkah 2 
                douth2perdh2=outh2*(1-outh2);
            %Langkah 3	
                dh2perdw4=x2;
            %Hasil dEtot / dw3
                dEtotperdw4=dEtotperdouth2*douth2perdh2*dh2perdw4;
        
        baruw1w2w3w4=[dE1perdy1 dE1perdouth1 dE2perdy2 dE2perdouth2 dEtotperdouth1 douth1perdh1 dh1perdw1 dEtotperdw1 dh1perdw2 dEtotperdw2 dE1perdouth2 dE2perdouth1 dEtotperdouth2 douth2perdh2 dh2perdw3 dEtotperdw3 dh2perdw4 dEtotperdw4];
        
        gabungw1w2w3w4=[lamaw1w2w3w4; baruw1w2w3w4];
        
        lamaw1w2w3w4=gabungw1w2w3w4;
    end
    
    %Updating Weight
        w5=w5-(lr*dE1perdw5);
        w6=w6-(lr*dE1perdw6);
        w7=w7-(lr*dE2perdw7);
        w8=w8-(lr*dE2perdw8);
        w1=w1-(lr*dEtotperdw1);
        w2=w2-(lr*dEtotperdw2);
        w3=w3-(lr*dEtotperdw3);
        w4=w4-(lr*dEtotperdw4);
    
    baruw1tow8=[w1 w2 w3 w4 w5 w6 w7 w8];
    
    gabungw1tow8=[lamaw1tow8; baruw1tow8];
    
    lamaw1tow8=gabungw1tow8;
    
    if Etot>=galat
        masiherror=true;
    end
end
Updating_Weight_W1_to_W8=['    w1' '        w2' '        w3' '        w4' '        w5' '        w6' '        w7' '        w8']
Hasil_Updating_Weight_W1_to_W8=[gabungw1tow8]

Forward_Pass=['    h1' '        h2' '        outh1' '     outh2' '     y1' '        y2' '        outy1' '     outy2']
Hasil_Forward_Pass=[gabungh1h2outh1outh2, gabungy1y2outy1outy2]

Total_Error=['    E1' '        E2' '        Etot']
Hasil_Total_Error=gabungE1E2Etot

col1=['    Col 1   ' 'Col 2      ' 'Col 3   ' 'Col 4      ' 'Col 5        ' 'Col 6      ' 'Col 7   ' 'Col 8     ' 'Col 9   ' 'Col 10    ' 'Col 11     ' 'Col 12     ' 'Col 13       ' 'Col 14     ' 'Col 15  ' 'Col 16    ' 'Col 17  ' 'Col 18   '];
col2=['    dE1/dy1 ' 'dE1/douth1 ' 'dE2/dy2 ' 'dE2/douth2 ' 'dEtot/douth1 ' 'douth1/dh1 ' 'dh1/dw1 ' 'dEtot/dw1 ' 'dh1/dw2 ' 'dEtot/dw2 ' 'dE1/douth2 ' 'dE2/douth1 ' 'dEtot/douth2 ' 'douth2/dh2 ' 'dh2/dw3 ' 'dEtot/dw3 ' 'dh2/dw4 ' 'dEtot/dw4'];
Update_W1_to_W4=[col1; col2]
Hasil_Update_W1_to_W4=gabungw1w2w3w4
 
col3=['    Col 1      ' 'Col 2      ' 'Col 3   ' 'Col 4   ' 'Col 5   ' 'Col 6   ' 'Col 7      ' 'Col 8      ' 'Col 9   ' 'Col 10  ' 'Col 11  ' 'Col 12  '];
col4=['    dE1/douty1 ' 'douty1/dy1 ' 'dy1/dw5 ' 'dE1/dw5 ' 'dy1/dw6 ' 'dE1/dw6 ' 'dE2/douty2 ' 'douty2/dy2 ' 'dy2/dw7 ' 'dE2/dw7 ' 'dy2/dw8 ' 'dE2/dw8 '];
Update_W5_to_W8=[col3; col4]
Hasil_Update_W5_to_W8=gabungw5w6w7w8