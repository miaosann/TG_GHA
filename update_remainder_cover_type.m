function result=update_remainder_cover_type(remainder_cover_type,temp_2)
a=remainder_cover_type;
for i=1:size(remainder_cover_type,2)
    if remainder_cover_type{2,i}==temp_2(1)
        a(:,i)=[];
    end
end
result=a;