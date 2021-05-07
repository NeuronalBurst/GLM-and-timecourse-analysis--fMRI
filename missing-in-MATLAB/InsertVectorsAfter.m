function resultVector=insertVectorsAfter(vector,new_elements,positions)

% input vector - 'vector'
% vector of elements to insert - 'new_elements'
% positions in the input vector to insert new_elements into - 'positions'

% positions=[2 4 6 8 10 13 16 19 21 24 27 30 32 35 38 41]; for Sub1
% positions=[2 4 6 8 10 13 16 19 21 24 27 30 32 35 38 41];

resultVector=NaN(1,length(vector)+length(new_elements)*length(positions));

n=0;
resultVector(1:positions(1))=vector(1:positions(1));
for i=1:length(positions)
     try
        resultVector(positions(i)+1+n:positions(i)+n+length(new_elements)+length(vector(positions(i)+1:positions(i+1))))=[new_elements vector(positions(i)+1:positions(i+1))];
        n=n+length(new_elements);
     catch ME
         if strcmp(ME.identifier,'MATLAB:badsubscript')
             resultVector(positions(i)+1+n:positions(i)+n+length(new_elements))=new_elements;
         else
             rethrow(ME)
         end
     end
    
end
