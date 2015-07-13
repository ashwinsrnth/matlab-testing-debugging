function out = common(first, second)
	out = [];
	for i = 1:length(first)
		for j = 1:length(second)
			if first(i) == second(j)
				out = [out, first(i)];
	    	end
		end
	end
end
