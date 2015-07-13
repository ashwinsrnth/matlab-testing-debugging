
## Common

We're trying to write a function `common`
that takes two lists, `first` and `second`,
and returns a list of their common elements:

Here's our implementation:

~~~
function out = common(first, second)
	out = [];
	for i = 1:length(first)
		for j = 1:length(second)
			if first(i) == second(j)
				out = [out, first(j)];
	    	end
		end
	end
end
~~~

Let's see if it works:

~~~
common([1], [1])
~~~

~~~
ans =  1
~~~

~~~
common([1], [2])
~~~

~~~
ans = [](0x0)
~~~

~~~
common([1,2,3], [1,2])
~~~

~~~
ans =

   1   2
~~~

Everything seems to be working so far.
Just a few more runs:

~~~
common([4, 1, 2, 3], [1, 2, 3])
~~~

~~~
ans =

   4   1   2
~~~

~~~
common([])
~~~

~~~
common([1, 2, 3], [4, 1, 2, 3])
~~~

~~~
error: common: A(I): index out of bounds; value 4 out of bound 3
~~~

This is not good. Our code seems to be working fine
for some inputs, but not so well for others.
Worse, for some inputs it produces an answer *without raising any errors*.

## Using a debugger to fix the problem


### Set a breakpoint

Let's start by setting a *breakpoint* at the point at which
we'd like our code to pause. Let's do this on line 2 of the function:

~~~
function out = common(first, second)
	out = []; % this line
	for i = 1:length(first)
		for j = 1:length(second)
			if first(i) == second(j)
				out = [out, first(j)];
	    	end
		end
	end
end
~~~

Now, from the command line, let's run our test case:

~~~
>> common([1,2,3], [4,1,2,3])
~~~

We'll notice that our prompt changes here:

~~~
K>>
~~~

Indicating that we are currently in debugging mode.

Cool! Now, we're *paused* inside the function.
We can, in this mode, examine local variables:

~~~
K>> first
~~~

~~~
first =

     1     2     3
~~~

~~~
K>> second
~~~


~~~
second =

     4     1     2     3
~~~

~~~
out
~~~

~~~
Undefined function or variable 'out'.
~~~

That's because we haven't *run* the line of code that
creates `out` yet. Let's do that by *stepping* through our code:

~~~
out
~~~

~~~
out =

     []
~~~

Awesome. Now let's step through our code a couple of times,
till we reach the conditional statement. Before
we actually run the conditional statement, let's see
what we're actually comparing:

~~~
first(i)
~~~

~~~
1
~~~

~~~
second(j)
~~~

~~~
4
~~~

Since those aren't equal, we don't expect the conditional statement
to execute, let's step and make sure that's what happens.

After stepping a couple of times, we're back at the conditional statement,
but now `first(i)` and `second(j)` have new values:

~~~
first(i)
~~~

~~~
1
~~~

~~~
second(j)
~~~

~~~
1
~~~

These are equal, so we want to add them to `out`.
We step through the code once more, and run the statement
that populates `out`. Let's look at `out` (keep in mind,
it should have the value `1`).

~~~
out
~~~

~~~
2
~~~

Hmmm. This is bad. Let's have a closer look at the command we just ran:

~~~
out = [out, first(j)];
~~~

Shouldn't that be `first(i)`? Let's quit debugging, make the change,
and try again:

~~~
function out = common(first, second)
	out = []; % this line
	for i = 1:length(first)
		for j = 1:length(second)
			if first(i) == second(j)
				out = [out, first(i)];
	    	end
		end
	end
end
~~~

~~~
>> common([1, 2, 3], [4, 1, 2, 3])
~~~

~~~
ans =

     1     2     3
~~~
