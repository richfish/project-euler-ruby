#Richard Fisher's scatch pad for Project Euler problems, all Ruby.


#1#######################
arr = []
(1...1000).to_a.each do |num|
  if num % 3 == 0 || num % 5 == 0
    arr << num
  end
end
puts arr.inject(&:+)

(1...1000).to_a.inject(0){ |memo, num| memo += num if num % 3 == 0 || num % 5 == 0 }



#2#######################
fib_arr = [1,2]
(3..4000000).inject(2) do |memo, num|
  if num == fib_arr[-1] + fib_arr[-2]
    fib_arr << num
    memo += num if num.even?
  end
  memo
end
#puts fib_arr.select{|g| g.even? }.inject(&:+)
#OR

arr = [1,2]
arr << arr[-1] + arr[-2] while arr[-1] <= 4000000
arr.select(&:even?).inject(&:+)


#3#######################
#cant do below... 600 billion numbers here
factors = []
num = 600851475143
(1..num).each do |i|
  factors << num if num % 1 == 0
end
puts factors
#instead, recursive strategy to "narrow down" the 1..num to make it manageable.

#step 1, get all of the factors
num = 600851475143
@factors = [2] #skip 1
def get_factors(num)
  (@factors[-1]..num).each do |i|
    if num % i == 0
      @factors << i
      get_factors(num/@factors[-1])
      return
    end
  end
end
get_factors(num)

#step 2, see if factors are prime using above
prime = []
@factors.each do |num|
  @factors = [2]
  get_factors(num)
  prime << num if @factors.size > 2 #itself and 1
end.max #return greatest



#4#######################
palindrones = []
(0..999).each do |i|
  (0..999).each do |n|
     prod = i*n
     palindrones << prod if prod.to_s == prod.to_s.reverse
  end
end
palindrones.max


#5#######################

#"evenly divisible, i.e. can have the same modulo value"
require 'benchmark'

def do_it
  arr = (1..10).to_a
  (20..1000000000).each do |num|
    modulos = []
    arr.each do |i|
      modulos << num % i
    end
    if modulos.uniq.size > 1
      next
    else
      return num
    end
  end
end
Benchmark.measure {
do_it
}

#attempt at more optimized way
#this cuts time by a third (doesnt iterate through the arr)
require 'benchmark'
@cow = "bad"
def do_it
  arr = [1,2,3,4,5,7,8,9,11,13,17,19]
  (1..100000000).step(0.50).each do |num|
    @modulos = []
    arr.each do |i|
      @modulos << num % i
      if @modulos[-2]
        if @modulos[-1] != @modulos[-2]
          break
        elsif @modulos[-1] == @modulos[-2] && @modulos.size == 12
          return @cow = num
        end
      end
    end
  end
end
Benchmark.measure {
do_it
}

#brute force: this worked
@cow = "bad"
def do_it
  arr = (1..20).to_a
  (1..1_000_000_000).each do |num|
    if arr.all?{ |i| num % i == 0 }
      return @cow = num
    end
  end
end
do_it



#not good for bigggg numbers... try it in way where don't go through xbillion.each numbers and instead building array from ground up...



##6#############################

(1..100).inject(&:+)**2 - (1..100).map{ |n| n**2 }.inject(&:+)



#7##############################
#For computing factors, instead of using the switching out iteration number based on discoverd factors... I'm breaking the first time something divisible is found. Very fast.
#key was figuring out how to mark as "prime" using the break method below. Check to see if final member of loop, which means it made it through the set without any factors.
puts "starting"
primes = [2,3,5,7,11,13]
(14..1_000_000_000).each do |num|
  break if primes.size == 10001
  (2..(num -1)).each_with_index do |n, i|
    break if num % n == 0
    primes << num if i == (num - 3)
  end
end
print primes.size
print primes.last




#8############################
num = "73167176531330624919225119674426574742355349194934
96983520312774506326239578318016984801869478851843
85861560789112949495459501737958331952853208805511
12540698747158523863050715693290963295227443043557
66896648950445244523161731856403098711121722383113
62229893423380308135336276614282806444486645238749
30358907296290491560440772390713810515859307960866
70172427121883998797908792274921901699720888093776
65727333001053367881220235421809751254540594752243
52584907711670556013604839586446706324415722155397
53697817977846174064955149290862569321978468622482
83972241375657056057490261407972968652414535100474
82166370484403199890008895243450658541227588666881
16427171479924442928230863465674813919123162824586
17866458359124566529476545682848912883142607690042
24219022671055626321111109370544217506941658960408
07198403850962455444362981230987879927244284909188
84580156166097919133875499200524063689912560717606
05886116467109405077541002256983155200055935729725
71636269561882670428252483600823257530420752963450".gsub!("\n", '')

products = []
num.split("").each_with_index do |n, i|
  break if num[i + 4].nil?
  products << (n.to_i * num[i + 1].to_i * num[i + 2].to_i * num[i + 3].to_i * num[i + 4].to_i)
end
print products.max


#9#############################

(1..1000).each do |a|
  (1..1000).each do |b|
    (1..1000).each do |c|
      if a + b + c == 1000 && a**2 + b**2 == c**2
        puts "found them"
        puts a
        puts b
        puts c
      end
    end
  end
end


#10#############################
#find all primes less than 1,000,000, sum them
#1 is not prime
#know for trial division, sqrt n is the highest divisor you need to try.
primes = [2,3,5,7]
(9..1_000_000_000).each do |num|
  break if primes[-1] > 2_000_000
  (2..(sqr = Math.sqrt(num).floor)).each_with_index do |n, i|
    break if num % n == 0
    primes << num if i == (sqr - 2)
  end
end
puts primes.delete_at(-1).inject(&:+)


#11###############################
#SERIOUS DIVIDE AND CONQUER
#format it to be array of arrays
#then do the left-right
#then the up-down
#then the diagnol

products = []

nums = "08 02 22 97 38 15 00 40 00 75 04 05 07 78 52 12 50 77 91 08
49 49 99 40 17 81 18 57 60 87 17 40 98 43 69 48 04 56 62 00
81 49 31 73 55 79 14 29 93 71 40 67 53 88 30 03 49 13 36 65
52 70 95 23 04 60 11 42 69 24 68 56 01 32 56 71 37 02 36 91
22 31 16 71 51 67 63 89 41 92 36 54 22 40 40 28 66 33 13 80
24 47 32 60 99 03 45 02 44 75 33 53 78 36 84 20 35 17 12 50
32 98 81 28 64 23 67 10 26 38 40 67 59 54 70 66 18 38 64 70
67 26 20 68 02 62 12 20 95 63 94 39 63 08 40 91 66 49 94 21
24 55 58 05 66 73 99 26 97 17 78 78 96 83 14 88 34 89 63 72
21 36 23 09 75 00 76 44 20 45 35 14 00 61 33 97 34 31 33 95
78 17 53 28 22 75 31 67 15 94 03 80 04 62 16 14 09 53 56 92
16 39 05 42 96 35 31 47 55 58 88 24 00 17 54 24 36 29 85 57
86 56 00 48 35 71 89 07 05 44 44 37 44 60 21 58 51 54 17 58
19 80 81 68 05 94 47 69 28 73 92 13 86 52 17 77 04 89 55 40
04 52 08 83 97 35 99 16 07 97 57 32 16 26 26 79 33 27 98 66
88 36 68 87 57 62 20 72 03 46 33 67 46 55 12 32 63 93 53 69
04 42 16 73 38 25 39 11 24 94 72 18 08 46 29 32 40 62 76 36
20 69 36 41 72 30 23 88 34 62 99 69 82 67 59 85 74 04 36 16
20 73 35 29 78 31 90 01 74 31 49 71 48 86 81 16 23 57 05 54
01 70 54 71 83 51 54 69 16 92 33 48 61 43 52 01 89 19 67 48".gsub!("\n", " ").split(" ").each_slice(20).to_a

#left-right
nums.each do |num_arr|
  num_arr.each_with_index do |num, i|
    break if num_arr[i + 3].nil?
    products << num.to_i * num_arr[i + 1].to_i * num_arr[i + 2].to_i * num_arr[i + 3].to_i
  end
end

#top down
#just using the raw numbers vs. names of arrays... pointless each with index
(0..19).each do |n|
  (0..19).each do |i|
    break if nums[i + 3].nil?
    products << nums[i][n].to_i * nums[i + 1][n].to_i * nums[i + 2][n].to_i * nums[i + 3][n].to_i
  end
end

#key to diagnols is the "extra j factor" that applies to either the array set or the item in array
#diagnol top right - bottom right - left column stays same
(0..19).each do |j|
  break if nums[j + 3].nil? #we know it can't do more
  (0..19).each do |n|
    break if nums[n + j + 3].nil?
    products << nums[n + j][n].to_i * nums[n + j + 1][n + 1].to_i * nums[n + j + 2][n + 2].to_i * nums[n + j + 3][n + 3].to_i
  end
end

#diagnol top right - bottom right - top row stays same
(0..19).each do |j|
  break if nums[0][j + 3].nil? #we know it can't do more
  (0..19).each do |n|
    break if nums[n + 3].nil? || nums[n + 3][n + j + 3].nil?
    products << nums[n][n + j].to_i * nums[n + 1][n + j + 1].to_i * nums[n + 2][n + j + 2].to_i * nums[n + 3][n + j + 3].to_i
  end
end

#diagnol bottom left - top right - left column stays same
(0..19).each do |n|
  break if 19 - n - 3 == -1 #negative values can keep going won't return nil
  (0..19).each do |j|
    break if 19 - j - n - 3 == -1
    products << nums[19 - n - j][j].to_i * nums[19 - n - j - 1][j + 1].to_i * nums[19 - n - j - 2][j + 2].to_i * nums[19 - n - j - 3][j + 3].to_i
  end
end

#diagnol bottom left - top right - bottom row stays the same
(0..19).each do |n|
  break if nums[19][n + 3].nil?
  (0..19).each do |j|
    break if 19 - j - 3 == -1 || nums[19 - j - 3][j + n + 3].nil?
    products << nums[19 - j][j + n].to_i * nums[19 - j - 1][j + n + 1].to_i * nums[19 - j - 2][j + n + 2].to_i * nums[19 - j - 3][j + n + 3].to_i
  end
end

puts products.size
puts products.max



#12##############################
#compute massive list of triangle numbers
#get factors for each one, find 1st over 500
#i flailed doing the sliding divisor thing... new idea with the divide by factor and add that as factor approach.

#to get triangle numbers, dont re-sum everything. gee's.
new_arr = [1]
(2..100_000).each_with_index do |num, i|
  new_arr << new_arr[i] + num
end

def get_factors(item, num)
  ((@factors[-1] + 1)..num).each do |i|
    if @factors.size > 500
      puts "over 500!"
      puts "triangle number is"
      puts item
      return
    end
    if item % i == 0
      return if item/i <= i
      @factors << i
      @factors << item/i
    end
      # puts "adding"
      # puts @facotrs[-1]
      # puts item/@factors[-1]
      #get_factors(item, item) #item/@factors[-1] this method has a flaw... I think some nums will be divisible by main num but not the factor/divided num.
     # return #because don't care about return to old stack stuff.
  end
end


def do_it(new_arr)
  new_arr.drop(0).each do |item|
    return if @factors && @factors.size > 500
    @factors = [item, 1]
    get_factors item, item
  end
end
do_it(new_arr)

#answ: 76576500

#13###############################################

num = "37107287533902102798797998220837590246510135740250
46376937677490009712648124896970078050417018260538
74324986199524741059474233309513058123726617309629
91942213363574161572522430563301811072406154908250
23067588207539346171171980310421047513778063246676
89261670696623633820136378418383684178734361726757
28112879812849979408065481931592621691275889832738
44274228917432520321923589422876796487670272189318
47451445736001306439091167216856844588711603153276
70386486105843025439939619828917593665686757934951
62176457141856560629502157223196586755079324193331
64906352462741904929101432445813822663347944758178
92575867718337217661963751590579239728245598838407
58203565325359399008402633568948830189458628227828
80181199384826282014278194139940567587151170094390
35398664372827112653829987240784473053190104293586
86515506006295864861532075273371959191420517255829
71693888707715466499115593487603532921714970056938
54370070576826684624621495650076471787294438377604
53282654108756828443191190634694037855217779295145
36123272525000296071075082563815656710885258350721
45876576172410976447339110607218265236877223636045
17423706905851860660448207621209813287860733969412
81142660418086830619328460811191061556940512689692
51934325451728388641918047049293215058642563049483
62467221648435076201727918039944693004732956340691
15732444386908125794514089057706229429197107928209
55037687525678773091862540744969844508330393682126
18336384825330154686196124348767681297534375946515
80386287592878490201521685554828717201219257766954
78182833757993103614740356856449095527097864797581
16726320100436897842553539920931837441497806860984
48403098129077791799088218795327364475675590848030
87086987551392711854517078544161852424320693150332
59959406895756536782107074926966537676326235447210
69793950679652694742597709739166693763042633987085
41052684708299085211399427365734116182760315001271
65378607361501080857009149939512557028198746004375
35829035317434717326932123578154982629742552737307
94953759765105305946966067683156574377167401875275
88902802571733229619176668713819931811048770190271
25267680276078003013678680992525463401061632866526
36270218540497705585629946580636237993140746255962
24074486908231174977792365466257246923322810917141
91430288197103288597806669760892938638285025333403
34413065578016127815921815005561868836468420090470
23053081172816430487623791969842487255036638784583
11487696932154902810424020138335124462181441773470
63783299490636259666498587618221225225512486764533
67720186971698544312419572409913959008952310058822
95548255300263520781532296796249481641953868218774
76085327132285723110424803456124867697064507995236
37774242535411291684276865538926205024910326572967
23701913275725675285653248258265463092207058596522
29798860272258331913126375147341994889534765745501
18495701454879288984856827726077713721403798879715
38298203783031473527721580348144513491373226651381
34829543829199918180278916522431027392251122869539
40957953066405232632538044100059654939159879593635
29746152185502371307642255121183693803580388584903
41698116222072977186158236678424689157993532961922
62467957194401269043877107275048102390895523597457
23189706772547915061505504953922979530901129967519
86188088225875314529584099251203829009407770775672
11306739708304724483816533873502340845647058077308
82959174767140363198008187129011875491310547126581
97623331044818386269515456334926366572897563400500
42846280183517070527831839425882145521227251250327
55121603546981200581762165212827652751691296897789
32238195734329339946437501907836945765883352399886
75506164965184775180738168837861091527357929701337
62177842752192623401942399639168044983993173312731
32924185707147349566916674687634660915035914677504
99518671430235219628894890102423325116913619626622
73267460800591547471830798392868535206946944540724
76841822524674417161514036427982273348055556214818
97142617910342598647204516893989422179826088076852
87783646182799346313767754307809363333018982642090
10848802521674670883215120185883543223812876952786
71329612474782464538636993009049310363619763878039
62184073572399794223406235393808339651327408011116
66627891981488087797941876876144230030984490851411
60661826293682836764744779239180335110989069790714
85786944089552990653640447425576083659976645795096
66024396409905389607120198219976047599490197230297
64913982680032973156037120041377903785566085089252
16730939319872750275468906903707539413042652315011
94809377245048795150954100921645863754710598436791
78639167021187492431995700641917969777599028300699
15368713711936614952811305876380278410754449733078
40789923115535562561142322423255033685442488917353
44889911501440648020369068063960672322193204149535
41503128880339536053299340368006977710650566631954
81234880673210146739058568557934581403627822703280
82616570773948327592232845941706525094512325230608
22918802058777319719839450180888072429661980811197
77158542502016545090413245809786882778948721859617
72107838435069186155435662884062257473692284509516
20849603980134001723930671666823555245252804609722
53503534226472524250874054075591789781264330331690".split("\n").map(&:to_i).inject(&:+).to_s[0..9]


#14##########################################

def walk_chain(num)
  if num == 1
    @chain_lengths[@init_num] = @chain + 1 #1 counts as part of the chain
    return
  end
  if num.even?
    @chain += 1
    walk_chain(num/2)
  else
    @chain += 1
    walk_chain(3*num + 1)
  end
end

@chain_lengths = {}
(1..999_999).each do |num|
  @chain = 0
  @init_num = num
  walk_chain(num)
end

puts "done"
puts @chain_lengths
puts @chain_lengths.size


#15###########################################

#represent 20x20 as coordinates
#traverse by indexing arrays, stop and add to collection array when get to [19,19]
#to traverse, an array of left-right instructions of length 20...
#to create set of instructions... go through each place with crazy algorithm...

#** realization, has to have equal numbers of ups and downs
#really a question about unique permutations. OR...

#understand that each "node" has only two paths of entry (that's a CS way to think)... from above or from left... so #ways to get to a node is sum of number of
#ways to get to above and left nodes
#THEN, because there is symmetry you don't need to represent it as a 20x20 array... just doubling of values
#use the construct of the inside loop proportional to iteration of outer loop... will go through half of it.

#KEYS: have to know about the -1 rows/columns having a +1 value...
#have to realize a node will be the sum of the node above and node to right... and have to know how that represents "possible paths" to the node.
#have to know how to build a board of some complexity for initial set up.
#have to learn how only "half" of the board needs setting up... and whether you even need to draw all the nodes on the board, etc.. probably shortcuts.

#create board, extra row for "1" values
board = []
21.times{ board << [] } #have to flesh out the arr of arr structure before you can assign values
0.upto(19) do |y|
  0.upto(19) do |x|
    board[y][x] = x
  end
end
20.times{ board[20] << 1 } #bottom row
20.times{ |n| board[n][20] = 1 } #right column

#set node values with the sums
0.upto(19) do |y|
  0.upto(19) do |x|
    node_val = board[y][x - 1] + board[y - 1][x]
    board[y][x] = node_val
  end
end


#16##################################################
#accomplished pretty simply.

#17##################################################
#lots of edge cases and things to keep track of
#agree to do edge cases last.
#first step, just get at core of what the pattern will be.
#edge cases: teens, even hundreds, thousand
#get basic implemnetation - will be errors, so go from there.

def set_lowest_digit(n)
  case n.to_i
  when 0 then ""
  when 1 then "one"
  when 2 then "two"
  when 3 then "three"
  when 4 then "four"
  when 5 then "five"
  when 6 then "six"
  when 7 then "seven"
  when 8 then "eight"
  when 9 then "nine"
  end
end

def set_two_digit(n)
  if n[0] == "0"
    set_lowest_digit n[1]
  elsif n.to_i.between?(10,19)
    case n.to_i
    when 10 then "ten"
    when 11 then "eleven"
    when 12 then "twelve"
    when 13 then "thirteen"
    when 14 then "fourteen"
    when 15 then "fifteen"
    when 16 then "sixteen"
    when 17 then "seventeen"
    when 18 then "eighteen"
    when 19 then "nineteen"
    end
  elsif n.to_i > 19
    first = case n[0].to_i
            when 2 then "twenty"
            when 3 then "thirty"
            when 4 then "forty"
            when 5 then "fifty"
            when 6 then "sixty"
            when 7 then "seventy"
            when 8 then "eighty"
            when 9 then "ninety"
            end
    first + (set_lowest_digit n[1])
  end
end

words = []
(1..1000).each_with_index do |n, i|
  puts "number! #{n}"

  str_n = n.to_s

  words <<  case str_n.size
            when 1
              set_lowest_digit str_n
            when 2
              set_two_digit str_n
            when 3
              if str_n[1..2] == "00"
                (set_lowest_digit str_n[0]) + "hundred"
              else
                (set_lowest_digit str_n[0]) + "hundredand" + (set_two_digit str_n[1..2])
              end
            when 4
              "onethousand"
            end
end

puts "done"
puts words.map(&:size).inject(&:+)



#18################################################

board = "75
95 64
17 47 82
18 35 87 10
20 04 82 47 65
19 01 23 75 03 34
88 02 77 73 07 63 67
99 65 04 28 06 16 70 92
41 41 26 56 83 40 80 70 33
41 48 72 33 47 32 37 16 94 29
53 71 44 65 25 43 91 52 97 51 14
70 11 33 28 77 73 17 78 39 68 17 57
91 71 52 38 17 14 91 43 58 50 27 29 48
63 66 04 68 89 53 67 30 73 16 69 87 40 31
04 62 98 27 23 09 70 98 73 93 38 53 60 04 23".split("\n").map{|g| g.split(" ")}.map!{|g| g.map(&:to_i)}


# board = board.split("\n").map{|g| g.split(" ")}
# board.map!{|g| g.map(&:to_i)}
#pattern here is can only go two ways per row... think 2.times loops for each row. Thats 2**n where n is number of rows -1.
#brute force, and then intelligent design.

#take notes about edge case as encounter
#edge case: first one differents


#if too confusing, do smaller scale implemenation first
# board = "75
# 95 64
# 17 47 82
# 18 35 87 10"



start = board[0][0]
sums = []

[0,1].each do |a|
  node1 = board[1][a]

  [a, a + 1].each do |b|
    node2 = board[2][b]

    [b, b + 1].each do |c|
      node3 = board[3][c]

      [c, c + 1].each do |d|
        node4 = board[4][d]

        [d, d + 1].each do |e|
          node5 = board[5][e]

          [e, e + 1].each do |f|
            node6 = board[6][f]

            [f, f + 1].each do |g|
              node7 = board[7][g]

              [g, g + 1].each do |h|
                node8 = board[8][h]

                [h, h + 1].each do |i|
                  node9 = board[9][i]

                  [i, i + 1].each do |j|
                    node10 = board[10][j]

                    [j, j + 1].each do |k|
                      node11 = board[11][k]

                      [k, k + 1].each do |l|
                        node12 = board[12][l]

                        [l, l + 1].each do |m|
                          node13 = board[13][m]

                          [m, m + 1].each do |n|
                            node14 = board[14][n]
                            sums << node1 + node2 + node3 + node4 + node5 + node6 + node7 + node8 + node9 + node10 + node11 + node12 + node13 + node14
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
#how to abstract this?
#ruby metaprogramming, make each of the 14 loops a method and use define_method...
#or try to condense to one method for recursive calls...


#abstracting it out
#KEY in general... anytime you have to do a set number of loops to accomplish something, you can implement recursively. Recusrive often a solution for just a
#large set of hardcoded loops...

#reduced to the single method.
def get_next(num, y_val, board)
  if y_val == 100
    buffer = []
    1.upto(100) do |n|
      buffer << instance_variable_get("@node_#{n}")
    end
    @sums << buffer.inject(&:+) + 75
    return
  end

  [num, num + 1].each do |n|
    instance_variable_set("@node_#{y_val}", board[y_val][n])
    get_next(n, y_val + 1, board)
  end
end


@sums = [] #get a long list of items in array, sum them by groups of 14 or 15 or something?
get_next(0, 1, board)




#19################################################
#my impulse when doing algorithms, to build up a representation with data structures of the "board" or the calendar set here.
#have to realize that assigning days of week to the calendar, can't arbitrarily start anywhere... have to start from the very beginning to get there.
#error on side of doing more than's necessary (ie the hash mapping)
#do the brute force and crude, go back refactor later.

#another approach: get all days in that time period, go through and assign the 1-7.. then chop up according to rules for months and see where it lands...

#step one, build the calendar representation, array of year-montharrays hashes
cal = {}
1900.upto(2000) do |year|
  month_arr = []
  (1..12).each_with_index do |month, ind|
    case month
    when 4, 6, 9, 11
      month_arr << (1..30).to_a
    when 2
      if year % 4 == 0 && !(year.to_s["000"] && year % 400 != 0)
        month_arr << (1..29).to_a
      else
        month_arr << (1..28).to_a
      end
    when 1, 3, 5, 7, 8, 10, 12
       month_arr << (1..31).to_a
    end
  end
  cal[year] = month_arr
end


#step two, assign days of the week values
#or change in plan... take the flattened array of values... and just do the 1 to seven, and everytime a 1 lands on a 1, count it...
#... have to make exception for 1900 (arr[0...365])
#concept of co-loop: neat structure of a repeating loop that moves in step with the main loop (not a sub loop, a co-loop)
day = 2 #sunday is 1
first_sundays = 0
flat_arr = cal.values.flatten
flat_arr.each_with_index do |val, i|
  day = 1 if day == 8
  if day == val && day == 1
    first_sundays += 1 unless i <= 364 #we dont care about 1900 for this
  end
  day += 1
end
puts first_sundays

#or could loop on year by year basis, but would have to pass the carry over (what day we're on) to the start of the next year.


#step three, count where sunday value falls on the zero index of month
#done above...

#20################################################
#pretty easy, basic ruby stuff
(1..100).inject(&:*).to_s.split("").map(&:to_i).inject(&:+)


#21################################################
#find all amicable nums and put in array; sum it.

def get_divisors_sum(n)
  nums = []
  (1..(n/2)).each do |i|
    nums << i if n % i == 0
  end
  nums.inject(&:+)
end

amics = []
(2..10000).each do |num|
  next if amics.include? num
  d_sum = get_divisors_sum(num)
  if num == get_divisors_sum(d_sum) && num != d_sum
    amics << num << d_sum
  end
end


#22################################################


(arr from file...)


letter_to_num = Hash[("a".."z").to_a.map.with_index(1).to_a]

#simple enough to do map instead of a new array.
arr2 = arr.map do |name|
  letter_val = 0
  name.split("").each do |letter|
    letter_val += letter_to_num[letter.downcase]
  end
  letter_val
end

arr2.each_with_index.map do |score, i|
  score * (i + 1)
end


#23################################################
#get to point where can figure out alternatives based on complexity...
#another way to optomize divisor problems is to save the divisors you calculate... dont need to recalculate them for certain numbers, etc.
#not using buffer arrays if your plan is to sum or multiply... use *= or += --> makes sense for inject then...

#possible:
#step one - get all abundant numbres under the limit (28123)
#step two - determine all possible sums of two abundant numbers where total is still under 28123 #n**2 complexity
#take that array with the sums, whatever numbers arent there up to 28123 is your answer

abun_nums = []
(12..28123).each do |num|
  if (1..(num -1)).inject(0){ |memo, val| memo += val if num % val == 0; memo } > num
    abun_nums << num
  end
end

sums_of_abuns = []
abun_nums.each do |num|
  abun_nums.each do |num2|
    if num + num2 <= 28123
      sums_of_abuns << num + num2
    end
  end
end
#gives really big array, but has a small set up uniques
sums = sums_of_abuns.uniq

no_sums = (1..28123).to_a - sums
no_sums.inject(&:+)

#good but have to take into account the caveat of the question...?
#or:
#go number by number up to 28123... get the divisors, determine if any two of it's divisors are abundant numbers, either or a yes or no, there's your answer.


#24################################################
#step one - create an array of all the permutations
#too easy in Ruby? 0, 1,2,3,4,5,6,7,8,9].permutation.to_a.sort
perms = []
[0,1,2,3,4,5,6,7,8,9].each do |num|
  [0,1,2,3,4,5,6,7,8,9].each do |n|
  end
end



#25################################################
#brute force: go through enough fibonacci numbers until number of digits == 1000

fibs = [1,1]

10000000000.times do
  if fibs[-1].to_s.size >= 1000
    puts fibs[-1]
    break
  end
  fibs << fibs[-2] + fibs[-1]
end



#26################################################

#step one, capturing the division results and formatting them for use
require 'bigdecimal'
arr = []
(1..1000).each do |num|
  result = BigDecimal.new('1.0').div(num, 5000) #may need to adjust
  #result = result.to_s.gsub("0.", "")
  arr << result
end
arr = arr.map{ |d| d.to_s("F").gsub("0.", "") }

#step two, determining the patterns and figuring out the longest one (and the iteration that has it)

#test
#cool, algo for determining repetitions in a string
#str = "142857142857142857142857142857142857142857"
#could do it like... hallf of the 500...

patterns = []
arr.each_with_index do |num, j|
  pattern_buf = []
  (0..5000).each do |i|  #some have more than 500 digits because of e-2 stuff
    next if i <= 20
    if num[(2*i + 1)].nil?
      if pattern_buf.empty?
        patterns << "0"
      else
        patterns << pattern_buf.min
      end
      break
    end
    if num[0..i] == num[(i+1)..(2*i + 1)]  #can get pattern but only want sub pattern...
      pattern_buf << num[0..i]
    end
  end
end

new_arr = patterns.map(&:size)
Hash[new_arr.map.with_index(1).to_a][new_arr.max]


#27################################################
#step 1 get pool of the prime numbers, to have a is_prime? checker
primes = [2,3,5,7]
(8..1_000_000).each do |num|
  limit = Math.sqrt(num).floor
  (2..limit).each_with_index do |num2, i|
    if num % num2 == 0
      break
    end
    primes << num if i == (limit - 2) #-2 because of zero offset and starting iteration at 2 not 1
  end
end

#step 2, set up the iteration... return an array with primes, a, b if it is over 80 consec. primes

success = []
(-999..999).each do |a|
  (-999..999).each do |b|
    consec_primes = 0
    (0..10000).each do |n|  #will never get through that many consec numbers... is safe
      quad = n**2 + (a*n) + b
      if primes.include? quad
        consec_primes += 1
      else
        success << [consec_primes, a, b, n] if consec_primes >= 2
        break
      end
    end
  end
end


#28################################################
#ruby doesn't provide a native structure for a co-loop... have to do yourself...
diags = [1]
skipn = 1
so_far = [skipn, 0] #0 corner, 1 skip #helper array to read and push from
corners = 0
(3..10_000_000).each do |num|
  puts skipn
  puts corners
  break if skipn > 1999
  if so_far[(-skipn)-1] == skipn
    diags << num
    corners += 1
    if corners == 4
      skipn += 2
      corners = 0
    end
    so_far << skipn
  else
    so_far << 0
  end
end

diags.inject(&:+)



#29################################################
#brute force... loop and inner loop, build array, get uniqs
results = []
(2..100).each do |a|
  (2..100).each do |b|
    results << a**b
  end
end
results.uniq.size

#30################################################
#pretty easy brute force
#but doesnt have to just be 5 digits, could be as many digits long as can imagine; probably some math rules about this.

results = []
(2..999_999).each do |num|
  str = num.to_s
  if (0..5).inject(0){ |memo, val| memo += str[val].to_i**5; memo } == num
    results << num
  end
end

#31################################################


coins = [0.01, 0.02, 0.05, 0.10, 0.20, 0.50, 1.0]

#editing it after doing it the first method
#combos from the rest: +2 for 4 x .50, 10 x .2
#total from after doing without the dollar:
#62822
combos = 2
(0..200).each do |m|
  (0..100).each do |m2|
    (0..40).each do |m3|
      (0..20).each do |m4|
        (0..9).each do |m5|
          (0..3).each do |m6|
            combos += 1 if (0.01*m + 0.02*m2 + 0.05*m3 + 0.10*m4 + 0.20*m5 + 0.50*m6) == 2.00
          end
        end
      end
    end
  end
end
print combos
(billion+ complexity)

#all non repeating permutations == 5040... can quickly see what adds up to 2 poounds exactly. NONE. obviously.
#repeating.... have to have some reoeaters
#first choise is dumb...
#more smart method?
#take out some of edge cases (like the dollar first), to eliminate a lot of the intensiveness...


combos = 0
combos += 1 # 1 x 2.0

#combos from 1 dollar stuff: 4563 (+ 62822) + 1 --> 67386 (minus any repeats... )
#all of the dollar ones
#combos += 1 # 2 x 1.00
#combos += 3 # 2 X .50 + 1.00, 5 x .20 + 1.00, 10 x .1 + 1.00

combos = 4 #from the above
(0..100).each do |m1|
  (0..50).each do |m2|
    (0..20).each do |m3|
      (0..9).each do |m4|
        (0..4).each do |m5|
          (0..1).each do |m6|
            combos += 1 if (0.01*m1 + 0.02*m2 + 0.05*m3 + 0.10*m4 + 0.20*m5 + 0.50*m6 + 1.0) == 2.00
          end
        end
      end
    end
  end
end
#brute force vs. actively building the solution... if given this config, what of left coins will equal 2.00

#breaking up dollar and rest of coins didn't help to much... got wrong answer... trying different approach:
@combos = 0

#do integers to make it easier
def try_01(sum)
  if (200 - sum) % 1 == 0
    @combos += 1
  end
end

def try_02(sum)
  if (200 - sum) % 2 == 0
    @combos += 1
  end
end

def try_05(sum)
  if (200 - sum) % 5 == 0
    @combos += 1
  end
end

def try_10(sum)
  if (200 - sum) % 10 == 0
    @combos += 1
  end
end

def try_20(sum)
  if (200 - sum) % 20 == 0
    @combos += 1
  end
end

def try_50(sum)
  if (200 - sum) % 50 == 0
    @combos += 1
  end
end

def try_100(sum)
  if (200 - sum) % 100 == 0
    @combos += 1
  end
end

#different ways to add up to 200, with 1,2,5,10,20,50,100, where ones can be repeated.

#^ no to the above...

#ways to get to 1p: 1
#ways to get to 2p: 2
#ways to get to 5p: 3
#ways to get to 10p: 10
#ways to get to 20p: 40
#ways to get to 50p: 450
#ways to get to 100p: 4562

(4562 + 4562) (4562 + 1) (1 + 1) (2)


#try ground up way of calculating combos and moving outward...


combos = 8 #for the all it coins
(0..199).each do |m|
  (0..99).each do |m2|
    (0..39).each do |m3|
      (0..19).each do |m4|
        (0..9).each do |m5|
          (0..3).each do |m6|
            (0..1).each do |m7|
              combos += 1 if 1*m + 2*m2 + 5*m3 + 10*m4 + 20*m5 + 50*m6 + 100*m7 == 200
            end
          end
        end
      end
    end
  end
end


#32################################################
#pandigital stuff, 5 on left size 4 on right...
#need a short cut for not having to hardcode all this...
#a minus loop --> for no repeat permutations
require 'benchmark'
Benchmark.measure {
products = []
("1".."9").each do |a|
  (("1".."9").to_a - [a]).each do |b|
    (("1".."9").to_a - [a, b]).each do |c|
      (("1".."9").to_a - [a, b, c]).each do |d|
        (("1".."9").to_a - [a, b, c, d]).each do |e|
          (("1".."9").to_a - [a, b, c, d, e]).each do |f|
            (("1".."9").to_a - [a, b, c, d, e, f]).each do |g|
              (("1".."9").to_a - [a, b, c, d, e, f, g]).each do |h|
                (("1".."9").to_a - [a, b, c, d, e, f, g, h]).each do |i|
                  if (a+b).to_i * (c + d + e).to_i == (f + g + h + i).to_i || (a).to_i * (b + c + d + e).to_i == (f + g + h + i).to_i
                    products << (f + g + h + i).to_i
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
}
#cool... just need way to shorten that, metaprogram that?

count = 0
def start_loopin(count)

end
#^ This is wrong because you can't repeat them... have to do permutations no repeats... 362880
#ruby permutation stuff..
Benchmark.measure{
products = []
("1".."9").to_a.permutation.to_a.each do |perm|
  if (perm[0]+perm[1]).to_i * (perm[2] + perm[3] + perm[4]).to_i == (perm[5] + perm[6] + perm[7] + perm[8]).to_i
    products << (perm[5] + perm[6] + perm[7] + perm[8]).to_i
  end
end
}
#how do I make my own permutation algo?

#33################################################
#the 1 and 3 quadrants are the same... take them out, the other digits actually reduce to the correct fraction.
non_t = []
(10..99).each do |num|
  (10..99).each do |denom|
    val = num/denom.to_f
    if val == num.to_s[0].to_i/denom.to_s[1].to_f && num.to_s[0] != num.to_s[1] && denom.to_s[0] != denom.to_s[1] && num.to_s[1] == denom.to_s[0]
      non_t << [num, denom]
    end
  end
end

#^ weird, when multiply the nums put over the multiplied denoms, ratio is 1/100... weird world of math.

#34################################################
#test to figure out upper bounds... 7 9's will produce seven digit number... 8 digits to be safe.

#this mysteriously borke, helped when did the puts num to see what is broke on instead of guessing.
#this seems like an irb bug. messed up

def get_fact(val)
 return 1 if val == 1
 answer = (1..val).inject(&:*)
 answer
end

success = []
(1..9_999_999).each do |num|
  num_s = num.to_s.split("")
  if num_s.inject(0){ |memo, val| memo + ( val.to_i.zero? ? 1 : (1..val.to_i).inject(&:*)) } == num
    success << num
  end
end
#+= no, just +

(1..100).each do |num|
  if (1..num).inject(0){ |memo, val| memo += val; memo } == 4
    puts "hi"
  end
end

#^this gets evaluated in weird way!


#35################################################
#get primes
#need to optomize, taking hour +

# primes = [2,3,5,7]
# (8..1_000_000).each do |num|
#   limit = Math.sqrt(num).floor
#   (2..limit).each_with_index do |num2, i|
#     if num % num2 == 0
#       break
#     end
#     primes << num if i == (limit - 2) #-2 because of zero offset and starting iteration at 2 not 1
#   end
# end
#all rotations have to be prime... so get rid of evens at least and others... preprocessing for initial iteration man....

#remmeber if wraping something in a block or something or a benchmark you wont have access to local variables outside of it
require 'prime'
Benchmark.measure{
@circulars = 13
  arr = (100..9_999_999).select{|v| v.odd? && v % 3 != 0 && v % 4 != 0 && v % 5 != 0 && v % 6 != 0 && v % 7 != 0 && v % 8 != 0 && v % 9 != 0 } #reduce by almost 1/10
arr.each do |num| #benchmarked to take about 30 minutes; have to make primes out of 9_000_000 since can be rotated; need to come up with quicker way to get primes
  num_arr = num.to_s.split("")
  rotations = [num_arr.dup]
  (num_arr.size - 1).times do
    rotations << (num_arr << num_arr.shift).dup
  end
  @circulars += 1 if rotations.all?{ |val| Prime.prime? val.join.to_i } #exponentially faster than primes.include? val
end
}

Benchmark.measure{
  arr = (100..9_999_999).select{|v| v.odd? && v % 3 != 0 && v % 4 != 0 && v % 5 != 0 && v % 6 != 0 && v % 7 != 0 && v % 8 != 0 && v % 9 != 0 } #writing it out like this instead of using
  #all? makes it almost 10 times faster
  puts arr.size
}

#36################################################
palins = []
(1..1_000_000).each do |num|
  if num.to_s == num.to_s.reverse && num.to_s(2) == num.to_s(2).reverse && num.to_s(2)[0] != "0"
    palins << [num, num.to_s(2)]
  end
end

#37################################################
#not considering 2 3 5 7
#smart to test the test example from the euler page first.
#very important to duplicate if making "copies" of arrays for whatever reason.
primes = [2,3,5,7]
(11..1_000_000).each do |num|
  limit = Math.sqrt(num).floor
  (2..limit).each_with_index do |num2, i|
    if num % num2 == 0
      break
    end
    primes << num if i == (limit - 2) #-2 because of zero offset and starting iteration at 2 not 1
  end
end

success = [] #have to define it out of hte loop if you want to be able to query it when done.
primes.each do |p|
  next if p == 2 || p == 3 || p == 5 || p == 7
  parr = p.to_s.split("")
  size = parr.size
  parr2 = parr.dup
  parr3 = parr.dup
  @rotations = [p]
  (size-1).times do
    parr2.shift
    parr3.pop
    @rotations.push parr2.join.to_i
    @rotations.push parr3.join.to_i
  end
  if @rotations.all?{ |val| primes.include? val }
    success << p
  end
end

#38################################################
#strategy... seek out the limits...
#each multiplication will result in at least 1 digit (can only have 9 digits)... so n can be 9 at most.
#have two dynamically varying & proportional sets: integer * {set}; at most digits; have to do some length * to make sure it stays under 9.
#beacuse wants at least (3) {1, 2, n}, integer can at most be 3 digits
#makes sense to think as dividing into two core parts... the interation (or recrusion), and the business. Helps to make a method for the business, then figure out the iteration.
@valid = []
def check_valid_concat(plier, plicand)
  str = ""
  plicand.each do |n|
    str << (n*plier).to_s
  end
  if str.split("").uniq.size == 9 && str.split("").size == 9 && !(str.split("").include? "0")
    @valid << str
  end
end

(1..9999).each do |plier|
  case plier.to_s.size
  when 4
    check_valid_concat plier, [1,2,3]
    check_valid_concat plier, [1,2]
    check_valid_concat plier, [1]
  when 3
    check_valid_concat plier, [1,2,3, 4]
    check_valid_concat plier, [1,2,3]
    check_valid_concat plier, [1,2]
  when 2
    check_valid_concat plier, [1,2,3,4,5]
    check_valid_concat plier, [1,2,3,4]
    check_valid_concat plier, [1,2,3]
    check_valid_concat plier, [1,2]
  when 1
    check_valid_concat plier, [1,2,3,4,5,6,7,8,9]
    check_valid_concat plier, [1,2,3,4,5,6,7,8]
    check_valid_concat plier, [1,2,3,4,5,6,7]
    check_valid_concat plier, [1,2,3,4,5,6]
    check_valid_concat plier, [1,2,3,4,5]
    check_valid_concat plier, [1,2,3,4]
  end
end
#probelm was this doesn't account for zero

#39################################################
success = []
(1..1000).each do |c|
  (1..1000).each do |b|
    (1..1000).each do |a|
      success << (a + b + c) if  a**2 + b**2 == c**2 && (a + b + c) <= 1000
    end
  end
end
#success.inject({}){|memo, val| memo[val] = success.count(val); memo} #arrange by number of times occurs
#actually get greatest from that... find out greatest value, then do rassoc

#the above is wrong... do it so finds the permiter

#40################################################
#messed up with the indexing 999 not 1001
str = ""
(1..1_000_000).each do |num|
  break if str.size > 1_000_000
  str << num.to_s
end

[0,9,99,999,9999,99999,999999].inject(1){ |memo, val| memo * (str[val].to_i) } #if append memo itll not work... just do that when creating a hash i guess
# [1,11,101,1001,10001,100001,1000001].each do |num|
#   puts str[num]
# end
# puts str[1].to_i * str[11].to_i * str[101].to_i * str[1001].to_i * str[10001].to_i * str[100001].to_i * str[1000001].to_i



[0,9,99,999,9999,99999,999999].each do |num|
  puts str[num]
end

#41################################################
#digits... 1...9, forget 1 digit ones...
#prime generation discussion

primes = []
(11..10_000_000).each do |num|
  limit = Math.sqrt(num).floor
  (2..limit).each_with_index do |num2, i|
    if num % num2 == 0
      break
    end
    primes << num if i == (limit - 2) #-2 because of zero offset and starting iteration at 2 not 1
  end
end

#ruby has a prime class that exposes Prime.prime?(n) to check if prime...

require 'benchmark'
require 'prime'
primes = []
Benchmark.measure{
primes = Prime.take_while{|p| p < 1_000_000_000 }
}

#Sieve of Eratosthenes
#as iterate to desired numbers, keep dividing evertything by iterators and elimiating what is left... when reach end will be stuff not divisible by anthing.
Benchmark.measure{
def update_arr(arr)
  arr.each do |n|
    if arr.any?{|val| }
  end
end
arr = (2..9_999_999).to_a
update_arr(arr)


# d_dig = []
# primes.each do |p|
#   if p.to_s.split("").uniq.size == p.to_s.size #so sloppy original implementation
#     d_dig << p
#   end
# end

#optomize based on purpose of use for primes... can take out a lot of the beginning iterations...
#primes where no repeat values... need 9 digits worth of them
require 'benchmark'
Benchmark.measure{
@starting = []
(11..999_999).each do |num|
  @starting << num if !num.to_s.split("").any?{ |val| val.to_i > num.to_s.size  } #uniq preping vs no larger digits than size; uniq takes 9.5 secs for 999_999., uniq reduces ;
  #starting size by 1/10; 10 secs for the val included in range of digits/ size approach... but it might eleminte a lot more upfront for cheaper--> close to 5/100 smaller
  #performance of all vs. any --> any is much smarter way. any does it in 8 seconds...
end
}

d_dig = []
primes.each do |p|
 if p.to_s.split("").all?{ |val| (1..(p.to_s.size)).to_a.include? val.to_i } && p.to_s.split("").uniq.size == p.to_s.size #humilitating too
   d_dig << p
  end
end

Benchmark.measure{
(1000..999_999_999).select{ |v| v.odd?}
}

require 'prime'
(1000..999_999_999).each do |n|
end
Benchmark.measure{
100000.times do
num = 1.to_s + 2.to_s + 3.to_s + 4.to_s + 5.to_s + 6.to_s + 7.to_s + 8.to_s + 9.to_s
end
}
Benchmark.measure{
10000.times do
num = [1,2,3,4,5,6,7,8,9].inject(""){|memo, val| memo + val.to_s}
end
}

#iteration that guarantees not re-using digits

#primes
#pandigital
#arr = (1000..999_999_999)
#special handling with zeros to get the less than 9 digits.
success = []
(0..9).each do |a|
  ((0..9).to_a - [a]).each do |b|
    ((0..9).to_a - [a,b]).each do |c|
      ((0..9).to_a - [a,b,c]).each do |d|
        ((0..9).to_a - [a,b,c,d]).each do |e|
          ((0..9).to_a - [a,b,c,d,e]).each do |f|
            ((0..9).to_a - [a,b,c,d,e,f]).each do |g|
              ((0..9).to_a - [a,b,c,d,e,f,g]).each do |h|
                ([1,3,4,5,7,9] - [a,b,c,d,e,f,g,h]).each do |i|
                  num = a.to_s + b.to_s + c.to_s + d.to_s + e.to_s + f.to_s + g.to_s + h.to_s + i.to_s
                  success << num.to_i if Prime.prime? num.to_i
                end
              end
            end
          end
        end
      end
    end
  end
end
#pandigital loop == permutation loop
#try with 9, then try with 8, etc. doing it that styl..
success = []
(4..9).each do |num|
  ("1"..num.to_s).to_a.permutation.to_a.each do |perm|
    success << perm.join.to_i if Prime.prime? perm.join.to_i
  end
end


#42################################################
letter_to_num = Hash[("a".."z").to_a.map.with_index(1).to_a]
#pasted from word.txt

word_val = []
arr.each do |word|
  word_val << word.split("").inject(0){|memo, val| memo + letter_to_num[val.downcase]}
end

tri_nums = [1,3,6]
20.times do
  tri_nums << (tri_nums.size + 1 + tri_nums[-1])
end

count = 0
word_val.each do |w|
  count += 1 if (tri_nums.include? w)
end

#43################################################
success = []
primes = [2,3,5,7,11,13,17]
("0".."9").to_a.permutation.to_a.each do |perm|
  (1..7).each do |i|  #a utility loop that coordinates moving through various arrays in the same loop
    if perm.join[i..(i+2)].to_i % primes[i-1] != 0
      break
    end
    success << perm.join if i == 7
  end
end


#44################################################
pents = []
(1..3000).each do |n|
  pents << (n*(3*n - 1))/2
end

#looping where they won't repeat... p and p2 doesn't matter which is which
# success = []
# pents.each do |p|
#   pents.each do |p2|
#     num = p + p2
#     num2 = (p - p2).abs
#     if (pents.include? num) && (pents.include? num2)
#       success << [p, p2]
#     end
#   end
#end

#going to try using combination(n)

#could refine the combinations to make sure a difference among them exists of a certain degree.
success = []
pents.combination(2).to_a.each do |co| #need better solution than this...
  num = co[0] + co[1]
  num2 = (co[0] - co[1]).abs
  if (pents.include? num) #&& (pents.include? num2)
    success << co
  end
end

s = []
success.each do |pair|
  print pair
  puts (pair[0] - pair[1]).abs
  s << pair if (pents.include? (pair[0] - pair[1]).abs)
end

pairs = []
(1..100).each do |n|
  (1..100).each do |n2|
    pairs << [n,n2]
  end
end

dups = 0
pairs.each do |m|
  if pairs.include? [m[1], m[0]]
    dups += 1
  end
end

p = []
(1..3).each do |a|
  (1..3).each do |b|
    p << [a,b]
  end
end


#45################################################
#can either look up formulas to test if number is triangle num or pent num or hex num... iterate through a set list and check for each three
#or generate three arrays with the types of nums, and iterate through a list of nums and check if belongs in all 3 or not.

tris = []
pents = []
hexs = []

(1..100000).each do |num|
  tris << ((num*(num + 1))/2)
  pents << ((num*(3*num - 1))/2)
  hexs << (num*(2*num - 1))
end

#if you had to, you could easily determine the index based on the value of the arr.
#could pre-processes the iteration list.. big gaps in these nums, etc.
#actually, just iterate through one of the tr/pent/hex arrays instead, since should belong in all there.
success = []
tris.each do |num|
  success << num if pents.include?(num) #&& hexs.include?(num) #only need to check 1 for now, then can run much shorter array later...
end
#getting to point where can buil algo  to get solution for most anything... just the performance and design of the algo not great...

require 'benchmark'
Benchmark.measure{
count = 0
(1..100_000_000).each do |num|
count +=1
end
}
#^takes comparatively no time at all to just iterate through the big arary (running calculation with formulas to see if triangle, hex, pent, etc.) compared to doing the array.include?
#check.
#benchmark: to iterate through a billion by itself takes... about a minute... 100_000_000 takes about 6 seconds. NEver want to iterate on the scale of a billion or even 100_000_000


#46################################################
#Goldbach's other false conjecture...

def check_for_conditions(num)
  @primes.each do |pr|
    return false if pr > num
    (1..100).each do |sq|
      next if (sq**2 + pr) > num #hits this
      if pr + 2*(sq**2) == num
        return true
      end
    end
  end
end

require 'prime'
@primes = Prime.take(100000)
arr = ((9..100_000).to_a - @primes).select{ |g| g.odd? }

success = []
expected = []

arr.each do |num|
  if check_for_conditions(num)
    expected << num
  else
    success << num
    break
  end
end


#47################################################
#system to get the factors for each number, then to check if they have 4 prime ones exactly.
#to figure out the three in a row... push all the ones that do into an array (push the num)... if the last one minnus the [-4] one has difference of three then you have 4 consecutive..

#hitting a pattern where i implement and then brainstorm ways to optimize, combine loops, set more intelligetn breaks, etc.
#use get factors loop to count primes too..

#uncertain whether only 4 prime factors or can have as many ...
def get_factors(num)
  primes = Prime.prime_division num
  if primes.size == 4
    @buffer << num
    return
  end
end


#   primes = []
#   prime_count = 0
#   #going to use Ruby here Prime.prime_division
#   (1..(num/10)).each do |n| #assumption is wrong aobut the Math.sqrt, prime factors can exceed the sqrt of the number!!! HAVE TO CHALLENGE ASSUMPTIONS.
#    # break if prime_count > 4 #another good optimizations
#
#
#     if num % n == 0 && Prime.prime?(n)
#       primes << n
#       prime_count += 1
#     end
#   end
#   if prime_count == 4
#     @buffer << [num, primes]
#     return
#   end
# end

# def no_overlap(set)
#  if (set.flatten - [2]).size == (set.flatten - [2]).uniq.size #.-([2]).size --> looks cooler
#    true
#  else
#    false
#  end
# end

require 'prime'

@buffer = []
count = 0
(1000..200_000).each do |num|
  if !@buffer[-4].nil?
    #break if @buffer.each_with_index.map{ |val, i| val - @buffer[i - 1] unless @buffer[i-1].nil? }.join("")["1111"] #breaks when there is 11...
    if (@buffer[-1] - @buffer[-4] == 3) && (@buffer[-4..-1].flatten.-([2]).size == @buffer[-4..-1].flatten.-([2]).uniq.size)     #no_overlap(@buffer[-4..1])
      puts "yipee!"
      break
    end
  end
  get_factors(num)
end




#48################################################
series = 0
(1..1000).each do |n|
  series += n**n
end
series.to_s[-10..-1]



#49################################################
#1..9000/2/2 (evens only) possible increase in sequence (or moves by 3330... only?); iterate through that (gap#)
#define a starting number and stopping number to serve as first in 3 series... set min and max limits based on gap#; only odds
#test if next number (and only if so then the next) if it a) is prime b) has same digits as first. If those check then do the next.
def all_good(base, num)
   (Prime.prime? num) && (num.to_s.split("").all?{ |dig| base.to_s.split("").include? dig })
end

require 'prime'
success = []
(1..4500).select{ |v| v.even? }.each do |gap|
  (1000..(10000 - gap*2)).each do |num| #before did it with a selct and odd? which means every iteration it will go through that. BAD.
    next if num.even?
    num2 = num + gap
    num3 = num + gap*2
    if all_good(num, num2) && all_good(num, num3)
      success << [num, num2, num3]
    end
  end
end

#50################################################
#could start with a million primes... for each prime determine whetehr can be composed by a sequence of primes added together consecutively..
#get smaller set of primes, and add it and the next x many to determine if that result is a prime or not.

require 'prime'
success = []
primes = Prime.take(5_000)
(0..primes.size).each do |i|
  (20..1000).each do |seq|
    break if i + seq > primes.size
    pr = primes[i..(i + seq)].inject(&:+)
    if Prime.prime? pr
      success << [pr, seq]
    end
  end
end

success.select{ |v| v[0] <= 1_000_000 }.rassoc(success.map{|v| v[1]}.max) #rassoc and tassoc, rassoc for array of arrays... tassoc for hashes to get at the value.



#51################################################
#require a new type of iteration, "slots" and all the combos for digits that can change...
#you know no reason to do last digit...
require 'prime'

def try_single_slot(num) #doesnt appear any signle slot will work for 5 digit, or 6?
  nums = num.to_s
  l = nums.size

  (0..(l-2)).each do |i| #hold off on first digit for now, and no reasno to do last (even digits)

    prime_count = 0
    miss_count = 0
    (0..9).each do |d|
      num2 = nums.dup

      num2[i] = d.to_s #again have to be really careful about not editing the object that needs to be the same each rotation.
      (Prime.prime? num2.to_i) ? prime_count += 1 : miss_count += 1

      if prime_count >= 8
        @success << [num, i]
        puts "got one!"
        return
      end
      break if miss_count > 2
    end
  end
end


def try_double_slot(num)
  nums = num.to_s
  slot_coms = nums.size == 5 ? @five_d_combos : @six_d_combos
  slot_coms.each do |com|
    prime_count = 0
    miss_count = 0
    (0..9).each do |d|
      num2 = nums.dup

      num2[com[0]] = d.to_s
      num2[com[1]] = d.to_s

      (Prime.prime? num2.to_i) ? prime_count += 1 : miss_count += 1

      if prime_count >= 8
        @success << [num, com] #only problem is this may not give the first given the combos...
        puts "huray!"
        return
      end
      break if miss_count > 2
    end
  end
end

def three_replacements(num)
  (num.size == 5 ? @five_digit : @six_digit).each do |combo|
    prime_count = miss_count = 0

    (0..9).each do |d|
      num2 = num.dup

      num2[combo[0]] = num2[combo[1]] = num2[combo[2]] = d.to_s

      (Prime.prime? num2.to_i) && num2[0] != "0" ? prime_count += 1 : miss_count += 1

      @success << [num, combo] && return if prime_count == 8
      break if miss_count > 2
    end
  end
end

#have to change these for 3 or 4 slots too...
#@five_d_combos = [0,1,2,3].combination(2).to_a  #helpful realization, way to get "slot" combinations to exhaust all possibilities.
#@six_d_combos  = [0,1,2,3,4].combination(2).to_a

@five_digit = [0,1,2,3].combination(3).to_a
@six_digit  = [0,1,2,3,4].combination(3).to_a
@success    = []
(10_000..999_999).each do |num|
  break if @success.size >= 1
  three_replacements(num.to_s)
end

#I GOT THIS doing the try_three where can use the 0 index digit... 121313

#extra analysis: would only need to check if 0,1,2 are primes... edge case of 000109... since there must be 8 members.
#note about has to be 6 digits, and has to be replacement of 3 digits (due to inevitable divisbility by 3 otherwise...)
#could have also generated big set of primes and just analysed that data.

#still things to try: first digit rotating
#4 digit rotations
#going through with the 7 digit numbers. @1,2, & 3

#52################################################
@success = []
(1..1_000_000).each do |num|
  digs = num.to_s.split("").sort
  if [2,3,4,5,6].all?{ |val| (val*num).to_s.split("").sort == digs }
    @success << num
    break
  end
end


#53################################################
count = 0
(2..100).each do |n|
  (1..n).each do |r|
    if (1..n).to_a.combination(r).size > 1_000_000
      count += 1
    end
  end
end



#54################################################

#hand = "8C TS KC 9H 4S 7D 2S 5D 3S AC".gsub("A", "14").gsub("K", "13").gsub("Q", "12").gsub("J", "11").gsub("T", "10").split(" ")
#one line needs to be passed to this



arr_of_hands.each do |hands|
  show_hands(hands)
end



@p_one_wins = 0

def show_hands(hands)
  hands       = format_hands(hands)
  p_one_score = assign_score(hands[0..4])
  p_two_score = assign_score(hands[5..9])
  # puts "one: #{p_one_score}"
  #  puts "two: #{p_two_score}"

  if p_one_score > p_two_score
    @p_one_wins += 1
  elsif p_one_score == p_two_score
    settle_tie p_one_score, hands[0..4], hands[5..9]
  end
end

def assign_score(hand)   #not assigning correctly! look carefully; getting false positives on straights because of duplicate cards.
  score = if royal_flush(hand) then 10
          elsif straight_flush(hand) then 9
          elsif four_of_kind(hand) then 8
          elsif full_house(hand) then 7
          elsif flush(hand) then 6
          elsif straight(hand) then 5
          elsif three_of_kind(hand) then 4
          elsif two_pairs(hand) then 3
          elsif one_pair(hand) then 2
          else 1 #just a high card
          end
end

def settle_tie(score, hand1, hand2)
  puts "tie: #{score}"
  print hand1
  print hand2
  hands1n = hand1.map{|g| g.dup}
  hands1n.map{|g| g[-1] = ""}
  hands2n = hand2.map{|g| g.dup}
  hands2n.map{|g| g[-1] = ""}

  case score #making assumption royal flush etc not coming into play; need to acccount for highest cards tieing and requiring next highest
  when 7
    @p_one_wins += 1 if hands1n.select{|g| hands1n.count(g) == 3}[0].to_i > hands2n.select{|g| hands2n.count(g) == 3}[0].to_i
  when 6
    @p_one_wins += 1 if hands1n.map(&:to_i).max > hands2n.map(&:to_i).max
  when 5
    @p_one_wins += 1 if hands1n.map(&:to_i).max > hands2n.map(&:to_i).max
  when 4
     @p_one_wins += 1 if hands1n.select{|g| hands1n.count(g) == 3}[0].to_i > hands2n.select{|g| hands2n.count(g) == 3}[0].to_i
  when 3
    @p_one_wins += 1 if hands1n.select{|g| hands1n.count(g) == 2}.uniq.map(&:to_i).max > hands2n.select{|g| hands2n.count(g) == 2}.uniq.map(&:to_i).max
  when 2
   if hands1n.select{|g| hands1n.count(g) == 2}[0].to_i == hands2n.select{|g| hands2n.count(g) == 2}[0].to_i
     if hands1n.map(&:to_i).max > hands2n.map(&:to_i).max
       @p_one_wins += 1
     end
   elsif hands1n.select{|g| hands1n.count(g) == 2}[0].to_i > hands2n.select{|g| hands2n.count(g) == 2}[0].to_i
     @p_one_wins += 1
   end
  when 1
    if hands1n.map(&:to_i).max == hands2n.map(&:to_i).max
      if hands1n.map(&:to_i).sort[-2] == hands2n.map(&:to_i).sort[-2]
        if hands1n.map(&:to_i).sort[-3] > hands2n.map(&:to_i).sort[-3]
          @p_one_wins += 1
        end
      elsif hands1n.map(&:to_i).sort[-2] > hands2n.map(&:to_i).sort[-2]
        @p_one_wins += 1
      end
    elsif hands1n.map(&:to_i).max > hands2n.map(&:to_i).max
      @p_one_wins += 1
    end
  end
end

def straight_flush(hand)
  if straight(hand)
    flush(hand)
  else
    false
  end
end

def royal_flush(hand)
  hand2 = hand.map{|g| g.dup}
  hand2.map{ |g| g[-1] = "" } #cant use the train here
  (hand2.map(&:to_i).sort == [10,11,12,13,14]) && flush(hand2)
end

def flush(hand)
  hand.map{ |g| g[-1] }.uniq == 1
end

def straight(hand)
  hand2 = hand.map{|g| g.dup}
  hand2.map{ |g| g[-1] = "" }
  hand2 = hand2.map(&:to_i).sort
  return false if hand2.uniq.size != hand2.size
  if hand2.include? 14
    if hand2[-2] - hand2[0] == 3
      true
    end
  elsif hand2[-1] - hand2[0] == 4
    true
  else
    false
  end
end

def four_of_kind(hand)
  hand2 = hand.map{|g| g.dup}
  hand2.map{ |g| g[-1] = "" }
  hand2.uniq.size == 2
end

def full_house(hand)
   hand2 = hand.map{|g| g.dup}
   hand2.map{ |g| g[-1] = "" }
   hand2.any?{ |c| hand2.count(c) == 3 } && hand2.any?{ |c| hand2.count(c) == 2 }
end

def three_of_kind(hand)
  hand2 = hand.map{|g| g.dup}
  hand2.map{ |g| g[-1] = "" }
  hand2.any?{ |c| hand2.count(c) == 3 }
end

def two_pairs(hand)
  hand2 = hand.map{|g| g.dup}
  hand2.map{ |g| g[-1] = "" }
  hand2.uniq.size == 3
end

def one_pair(hand)
  hand2 = hand.map{|g| g.dup}
  hand2.map{ |g| g[-1] = "" }
  hand2.uniq.size == 4
end

def format_hands(hands)
  hands.gsub("A", "14").gsub("K", "13").gsub("Q", "12").gsub("J", "11").gsub("T", "10").split(" ")
end

#messed up because have to be careful how the map, mutating the strings what it will return... returns the crap taken off not the new array.

#55################################################
@lychel = 0
(1..10_000).each do |num|
  iterate(num, 0)
end


def iterate(num, iter)
  puts num
  if iter >= 54
    @lychel += 1
    return
  end

  sum = num + num.to_s.reverse.to_i
  if sum.to_s == sum.to_s.reverse
    return
  else
    iterate(sum, iter += 1)
  end
end

#56################################################

sums = []
(1..100).each do |a|
  (1..100).each do |b|
    sums << (a ** b).to_s.split("").map(&:to_i).inject(&:+)
  end
end

#57################################################
#can get the decimal and then .to_r to get a fraction, and then regexp to figure out sizes of num and denom.
#how to generate the sequence
#take the result and make it a string then call .to_r to make it a fraction.
#scan... will return arrays with results
#gsub with () will allow you to sub JUST the capture and that's alls

numer = 0
seq = "1 + 1/(2 + 1/(2 + 1/2))"
5.times do
  seq = seq.gsub(/(2)(\)+)$/, "(2 + 1/2)" + $2) #should respect bracets! #problem, it was still holding onto this dollar sign 2 so it was making it freak out.
  #new_seq
end


numers = 0
(1..998).each do |num|
  ans = 2.5.to_r
  num.times{ ans = (2 + 1/ans.to_s.to_r) }
  final = (1 + 1/ans)

  numer, denom = final.to_s.scan(/(.+)\/(.+)/).first
  numers += 1 if numer.size > denom.size
end

#solutions completely invert it


#diff approach, have to evaluate the little building blocks and substitue ans.to_s.to_r for each of them, have to do it n -1 times, where nth is the term it is



#58################################################
#borrowing diagnol code from before...
require 'prime'

#modified to report the skipn with the diags.

diags = [1]
skipn = 1
@ratio = 0
thing = 0
thing2 = 0
thing3 = 0
thing4 = 0
so_far = [skipn, 0] #0 corner, 1 skip #helper array to read and push from
corners = 0
(3..900_000_000).each do |num|
  break if skipn > 5
  if so_far[(-skipn)-1] == skipn
    diags << [num, skipn]

    if @ratio != 0
      if Prime.prime? num
        @primes += 1
        @ratio = @primes/(diags.size.to_s + ".0").to_f
        if @ratio < 0.103 && thing == 0 #will hit this repeatedly every iteration not just once
          puts "less .103"
          thing += 1
        end
        if @ratio < 0.102 && thing3 == 0 #will hit this repeatedly every iteration not just once
          puts "less .102"
          thing3 += 1
        end
        if @ratio < 0.101 && thing4 == 0 #will hit this repeatedly every iteration not just once
          puts "less .101"
          thing4 += 1
        end
        if @ratio < 0.10
          puts "below ratio!"
          break
        end
      end
    end

    corners += 1
    if corners == 4
      skipn += 2
      corners = 0
    end
    so_far << skipn
  else
    so_far << 0
  end

  if diags.size == 30000 && thing2 == 0 #is going to hit this like a thousan times before the next diagnol
    puts "getting prime size"
    @primes ||= diags.select{ |g| (3..5000).to_a.none?{ |f| g[0] % f == 0  }}.select{ |f| Prime.prime? f[0] }.size
    @ratio = @primes/50000.0
    puts "done with primes"
    thing2 += 1
  end
end
#this is wayyyy too slow.

# def get_ratio(diags)
#   (diags.select{ |f| Prime.prime? f }.size)/(diags.size.to_s + ".0").to_f
# end

#because the baove is so costly. lets get the array, figure out a point where it goes over, and then work backwards to where it first falls below 10%, noting the number
#or figure out what the ratio is all along... and then go from there.


#could brute force optomize...
#when hit one corner (because you know the skip, you can get the rest of the corners)... and add to the skip.... can quickly get tons and tons of corner values
#try doing above algo same as above but with the faster corner generation and see how soon the .3 and .2 .1 etc come.

# def calc_ratio
#   @ratio = @primes/((@diags.size.to_s + ".0").to_f)
#   puts @ratio
# end

require 'prime'
@diags = [1,3,5,7,9] #THIS IS 3 PRIMES OMG
@primes = 3
@ratio = 1
@break = false
skipn = 3
thing3 = 0
thing2 = 0
thing1 = 0
#def add_diags(skipn)
1_000_000.times do   #have to think about whether a recursive call or just a brute force do this a million times implementation is better
  #a while loop might have been approproiate... while the return value of the function is false, do this until it is true.
 # calc_ratio
  4.times do #make sure put this in right place...
    @ratio = @primes/((@diags.size.to_s + ".0").to_f)

   # break if skipn > 30_000

    if @ratio < 0.103 && thing3 == 0 #odd way of ding case statements...
      puts "less 0.103"
      thing3 +=1
    elsif @ratio < 0.102 && thing2 == 0
      puts "less 0.102"
      thing2 +=1
    elsif @ratio < 0.101 && thing1 == 0
      puts "less 0.101"
      thing1 +=1
    elsif @ratio < 0.100000
      puts "success"
      @break = true
      break
    end


    num = (@diags[-1] + skipn + 1)
    @diags << num
    @primes += 1 if (Prime.prime? num)
  end
  break if @break
  skipn += 2
  #add_diags(skipn += 2)
end
#failed assumption is that ratio will only change when a prime is added, ratio should always be changing!

#EXPOENTIALLY FASTER THAN THE ABOVE/FIRST METHOD
#rule of thumb! avoid the raw 1..billion iteration... dont have to do that here.
#finishes with skipn == 26255 #26241... why??? #now gives 26245... its 4 off! wtf!

#$^this takes too long...
#can't always nest function inside of function... stack level too deep

#add_diags(skipn)

# case 5 #should look up how to do this in ruby...
# when < 5
#   puts 'Hi'
# when < 4
#   puts "bit"
# end




#59################################################
#65 - 90 are the letters...
#have to XOR 3 chars at a time with a key of 3
#arr

solution_asciis = []

("97".."122").each do |k|
  ("97".."122").each do |k1|
    ("97".."122").each do |k2|
      case (k + k1 + k2).size
      when 6
        solution_asciis <<  (str.to_i ^ ((k + k1 + k2)*333 + k + k1).to_i) #may be wrong here... arr/str == 2002, and multiplied stuff == 2401... igo=nore the comas;
      when 7
        solution_asciis <<  (str.to_i ^ ((k + k1 + k2)*286).to_i) #*286 == 2002
      when 8
        solution_asciis <<  (str.to_i ^ ((k + k1 + k2)*250 + (k.size == 2 ? k : k[0..1])).to_i) #*250 == 2000
      when 9
        solution_asciis <<  (str.to_i ^ ((k + k1 + k2)*222 + k + k1[0]).to_i) #*222 == 1998
      end
    end
  end
end

arr = solution_asciis.map{ |g| g.to_s }.map{ |f| f.scan(/.{2}/) }.map{|r| r.map(&:to_i) } #array of arrays of the two ascii chars... then need to map with the .chr, and then combine them to read the words

arr3 = arr2.select{|f| f["THE"]} #no go
#needs to be lower case ASCII keys, not uppercase...
#frequency analysis is a big part of crypto... the letter e occurs 12.7% of the time!

#^appears to be wrong approach... we should encyprt it key character by character...

#its ascii character to character... so a 97 could XOR with a 140, and those need to line up
#^need to work with arrays instead so can go el for el to produce a new arary of els.

def xor_build_solution(key_arr, encrypt_arr) #assumes arrs will be same length
  collector = []
  if key_arr.size != encrypt_arr.size
    puts "arrs dont match, skipping"
    return
  end

  key_arr.each_with_index do |k, i|
    collector << (encrypt_arr[i] ^ k) #XOR has funny order of evaluation
  end
  @poss_solutions << collector
end

@poss_solutions = []

(97..122).each do |k|
  (97..122).each do |k1|
    (97..122).each do |k2|
      key_arr = ([k,k1,k2]*400 + [k])  #simplified... just has to add up to 1201, *400 and then 1k
      xor_build_solution(key_arr, e_msg)
    end
  end
end

arr2 = @poss_solutions.map{|f| f.map{|o| o.chr }}.map{|f| f.join}
arr2.select{|g| g["God"]} #its the 5th one

#just need to find sumn of ascii values of the decrypted text.

#pos answer: 107359



#60################################################
#CONCEPT: optimisize the brute force... still brute froce but at least optomized
#to through primes and test whetehr contacting them results in a prime or not. Have to test out a set of 5 to see if this property holds for all of them...
#have to test 10 combos for each 5-set config
#have to call prime? on the concatenated results for each check
#can optomize brute force --> if the first two aren't prime then stop...

#try with first 1000 primes to see how works.





#optomize in that cannot repeat, so can skip taht... #my ugly solution for havig it not repeat
#optomize so that if one pair doesn't work, break on the level of the first or second instead of going through with the rest. --> try putting logic in betweenthe loop cascade.
#THE LOOP CASCAPDE
#making an assumption about doing this in a sort of order...
#AWESOME NEW STRUCTURE
def do_work #just so have someting to return from, is that really a legit reason to use a method... way ot break far through stack:... give it the exit signal?
  primes = Prime.take(2000)
  primes.each_with_index do |a, ia|
    primes[(ia + 1)..-1].each_with_index do |b, ib|
      next if !concat_primes(a,b) #but not just the two, when you have more, have to do all the combos.; #but remember if you 'break' that loop is through....
      primes[(ib + 1)..-1].each_with_index do |c, ic|
        next if !(concat_primes(a,c) && concat_primes(b,c))
        primes[(ic + 1)..-1].each_with_index do |d, id|
          next if !(concat_primes(a,d) && concat_primes(b,d) && concat_primes(c,d))
          primes[(id + 1)..-1].each do |e|
            next if !(concat_primes(a,e) && concat_primes(b,e) && concat_primes(c,e) && concat_primes(d,e))
            @solution = [a,b,c,d,e] #what if more than one solution?
            return
          end
        end
      end
    end
  end
end
#want to produce lowest sum, not necessarily the lowest starting number or two...
#pre-processing to find primes that can be concatenated to produce primes, so you have a more narrow set? Question worth asking.

def concat_primes(num, num2)
  (num.to_s + num2.to_s).to_i).prime? && (num2.to_s + num.to_s).to_i).prime?
end

require 'prime'
do_work

#60 A LOT STARTED CLICKING
#SOLID BRUTE FORCE OPTIMIZATION, ALONG WITH TIER LOGIC.
#ALWAYS THINK ABOUT THIS
#progressive iterations for nested loops optimization! #INSIGHT... Progressive nested loops... where nested loop doesn't go lower than # before it...just higher!
#this is when you don't want to repeat combinations tried earlier...
#implement that with select{} to get the greater in value set... or each with index and use an index??

#^this should work... taking too long, maybe try variable #of primes... know what range the primes will be in... could help


#61################################################
#6 types of numebrs, solution 6 need to represent each of those...
#6 4 digit numbers, they need to be cyclicl... last two of first wil make first two of next... last two of last make first two of first.
#cant raw generate all the cyclic numbers from the first..
#TRY: start with first of 6... make sure it is in one of the six (register which one).then, generate those digits that we can. Then test 1 by 1 for inclusion in the remaining sets.
#easier: we know they are all 4 digit numbres, so size of pent, hex, sets. etc should be small.

#STEP 1 get all the sets of the diff types, they are small, good :)

#STEP 2-
#edge case? digits that start with zeros? assume we can't... or?; assume we can start with zeros.
#lets borrow the middle-next-loop design; #save progress loop
#^Define general structure
#the specific iterators dependent on cyclical implementation...
#
# 1 - "2345"
# 2 - "45__" #iterate through twos... "33"
# 3 - "33__" #iterate through twos... "44"
# 4 - "44__" #iterate through twos... "55"
# 5 - "55__" #iterate through twos... "66"
# 6 - "6623"
#^Whiteboarding to figure out best approach

#performance losses by using strings, but easier to manipulat ethe digits due to how its required
def go_and_work
  ("1000".."9999").each do |start|
    @groups_so_far = [] #reset it everytime iterate through a new base number
    next if !(unused_groups start)
    ("00".."99").each do |a|
      next if !(unused_group (start[2..3] + a)) #do a check to #TIER LOGIC LOOPS, LOGIC AT EACH TIER; MIDDLE LOGIC LOOP.
      ("00".."99").each do |b|
        next if !(unused_group (a[2..3] + b))
        ("00".."99").each do |c|
          next if !(unused_group (b[2..3] + c))
          ("00".."99").each do |d|
            next if !(unused_group (c[2..3] + d))
            next if !(unused_group (d[2..3] + start[0..1]))
            puts "amazing"
            print [start, start[2..3] + a, a[2..3] + b, b[2..3] + c, c[2..3] + d, d[2..3] + start[0..1]]
            return
            #look up how to run a break statement all the way to the top!
          end
        end
      end
    end
  end
end
#has an apparent large complexity as well... but the tier logic will reduce it expotentially
#has a one directional flow to it... what if got numbers in groups on other ends and wanted to adjust the first one more...

#sets so far structure to track which of 6 groups we've hit...
#3,4,5,6,7,8 --
@groups_so_far = []
#need method to check mere belonging to a group that's not been used

#two jobs, figure out the group its in, if unused, add it and return true, otherwise return false
def unused_group?(num)
  num = num.to_i
  if tri.include?(num) && !@groups_so_far.include?(3)
    @groups_so_far << 3
  elsif sqr.include?(num) && !@groups_so_far.include?(4)
    @groups_so_far << 4
  elsif pent.include?(num) && !@groups_so_far.include?(5)
    @groups_so_far << 5
  ...
end
#^Massive iteration style is one solution
#Another is figuring out which 4 digit numbers are in those groups... and then see if we can iterate to arrnage them in the way they should...

#LETS GET ALL 4 digit numbers from the different groups and try to see which are rotate-able
#doing the latest would have about a 60**6 complexity, minus a certain amount because no repeating at same time...
#actually NO... you grab the second number based on the first, so its not crazy trying over and over

def get_tri
  set = [1]
  (1..1000).each do |n|
    set << (n*(n+1))/2
    return set[0..-2] if set[-1].to_s.size == 5
  end
end

def get_sqr
  set = [1]
  (1..1000).each do |n|
    set << n**2
    return set[0..-2] if set[-1].to_s.size == 5
  end
end

def get_pent
  set = [1]
  (1..1000).each do |n|
    set << (n*(3*n -1))/2
    return set[0..-2] if set[-1].to_s.size == 5
  end
end

def get_hex
  set = [1]
  (1..1000).each do |n|
    set << (n*(2*n -1))
    return set[0..-2] if set[-1].to_s.size == 5
  end
end

def get_hept
  set = [1]
  (1..1000).each do |n|
    set << (n*(5*n -3))/2
    return set[0..-2] if set[-1].to_s.size == 5
  end
end

def get_oct
  set = [1]
  (1..1000).each do |n|
    set << (n*(3*n -2))
    return set[0..-2] if set[-1].to_s.size == 5
  end
end


tri = get_tri
sqr = get_sqr
pent = get_pent
hex = get_hex
hept = get_hept
oct = get_oct



#ALT APPROACH   #720 permutations for the three... of how can sample from different groups
[tri, sqr, pent, hex, hept, oct].each do |set|
  set.select!{|f| f.to_s.size == 4 } #cant do this without the mutating... otherwise might have to do ivar set and ivar get
end

arr = [tri, sqr, pent, hex, hept, oct] #co-loop, with the with_index
["tri", "sqr", "pent", "hex", "hept", "oct"].each_with_index do |var, i|
  instance_variable_set("@#{var}", arr[i])  #a way to use eval here. But in general you don't want to use eva??
end


#I may not need the .empty? next part, because if the next nested loop just tries to go off of a [] it will throw back up to another next?
def do_work
  ["tri", "sqr", "pent", "hex", "hept", "oct"].permutation.to_a.each do |perm| #720 permutations, #have to use strings!
    instance_variable_get("@#{perm[0]}").each do |one|
      instance_variable_get("@#{perm[1]}").select{ |a| a.to_s[0..1] == one.to_s[2..3] }.each do |a|
        instance_variable_get("@#{perm[2]}").select{ |b| b.to_s[0..1] == a.to_s[2..3] }.each do |b|
          instance_variable_get("@#{perm[3]}").select{ |c| c.to_s[0..1] == b.to_s[2..3] }.each do |c|
            instance_variable_get("@#{perm[4]}").select{ |d| d.to_s[0..1] == c.to_s[2..3] }.each do |d|
              six = instance_variable_get("@#{perm[5]}").select{ |e| e.to_s[0..1] == d.to_s[2..3] && one.to_s[0..1] == e.to_s[2..3] }
              if !six.empty?
                @success = [one, a, b, c, d, six.first]
                puts "success"
                return
              end
            end
          end
        end
      end
    end
  end
end

do_work
#does it almost instantly. YAY!
#I HAD ORIGINALLY WRITTEN THIS WITH IF ELSE NEXT STATEMENTS APPEARING ALL OVER THE PLACE


#62################################################
#get an array of all the cube results 1..1000
#sort and see if same digits
#lets use two arrays, the normal results, and then the mapped digit sorted... use count() to see if more than 5, get the index to use against the first array
cubes = []
(1..10000).each do |num|
  cubes << num**3
end

sorted = cubes.map{|f| f.to_s.split("").sort.join }
sorted.each_with_index{|f,i| puts "success: #{i}" if sorted.count(f) == 5} #dont do the &&break thing... mess up anything else... it will just return nil before it prints anything


#63################################################
#10**r... will always have digits +1 whatever the power is. so can't iterate beyond 10
#for each base n, we'll go through the powers, and count how many of those results have the same # of digits as the power...
count = 0
hmm = []
(1..1000).each do |n|
  (1..1000).each do |r|
    if (num = (n**r)).to_s.size == r
      count += 1
      hmm << num
    end
  end
end
#failure... can go to 10 n or over... just increase the amount if requires that little resource.
#64################################################
#skip ones that have perfect square, 4, 9, 16, 25, etc.
#requires knowing what continued fractions are... cuttig off chunks of squares to make new squares... how 3/13 == 1/(13/3) == 1/(4 + 1/3) == 1/(4 + 1/(3/1)) DONE


#65################################################
#convergants for e

#follows pattern
#constant is the 1/...
2
2 + 1/1
2 + 1/(1 + 1/2)
2 + (1/(1 + 1/(2 + 1/1)))
2 + (1/(1 + 1/(2 + (1/(1 + 1/1)))))
2 + (1/(1 + 1/(2 + (1/(1 + 1/(1 + 1/4))))))

#think of the terms as the isolate (1 + 1/x)

pattern = [1,2]
g = 4
500.times do
  pattern << [1,1,g]
  g += 2
end
pattern = pattern.flatten.take(99)

#do the 1 + 1/var evaluation with num of times you want to do it.
ans = (pattern[-2] + 1/(pattern[-1].to_s.to_r))
(pattern.take(97)).reverse.each do |num| #start from depth and move to more recent... #the subtracting the last two is bad because it subtracts ALL instances of the last two. Take works.
  ans = (num + 1/ans) #starts with the last term (4)... variable num + 1/last term (ans = last term)
end
ans = (2 + 1/ans)

#7 terms in there will give 10... so create a whole bunch of and take first 997 (and put 998 and 999 in the starter)

#generate pattern:

#start with 2 and add a 1 at the end to the front...


#66################################################
#D cannot be a square? or what does square mean? Assumption: D is not a square.

def check_the_d(d)
  (10_000_000..500_000_000).each do |x| #guarantees x will be going from low to high, so when returns will be min solution x.; the lrange is adaptable since already tested...
    y_sqr = (x**2 - 1)/d.to_f #this may be incorrect refactoring...
    sqr_r = Math.sqrt(y_sqr)
    if sqr_r == sqr_r.to_i
      @min_sols << [d, x, sqr_r]
      return
    end
  end
end
#modify this so we compute y instead of raw iterating... #before was iterating through y raw... 10,000 * 10,000 * 1,000 ugh
#what if created an array of squares less than...? Then no Math.sqrt call.

#squares less than 1000
@min_sols = []
#((2..1000).to_a - (2..32).to_a.map{|g| g**2} - d_arr - d2_arr - d3_arr - d4_arr - d5_arr).each do |d| #969 items, #d_arr is results from x < 1000 which wasn't enough... lets skip these d's.
Benchmark.measure{
[85].each do |d|
  check_the_d(d)
end
}

the_346 =  [89, 97, 103, 106, 109, 125, 134, 139, 149, 151, 157, 163, 166, 172, 181, 193, 199, 201, 202, 211, 213, 214, 218, 233, 236, 237, 241, 244, 250, 253, 259, 261, 262, 263, 265, 268, 271, 277, 281, 283, 284, 286, 293, 298, 301, 307, 309, 310, 311, 313, 314, 317, 319, 331, 334, 337, 338, 340, 341, 343, 347, 349, 353, 354, 355, 356, 358, 365, 366, 367, 370, 373, 379, 382, 386, 388, 393, 394, 397, 403, 406, 409, 412, 413, 415, 417, 419, 421, 424, 425, 431, 433, 436, 445, 446, 449, 451, 454, 457, 459, 461, 463, 466, 469, 472, 474, 477, 478, 481, 487, 489, 491, 493, 498, 500, 501, 502, 508, 509, 511, 512, 513, 517, 519, 521, 523, 524, 526, 533, 536, 537, 538, 540, 541, 543, 547, 549, 550, 553, 554, 556, 559, 561, 562, 565, 566, 569, 571, 581, 586, 589, 591, 593, 596, 597, 599, 601, 604, 605, 606, 607, 609, 610, 611, 613, 614, 617, 619, 622, 628, 629, 631, 633, 634, 637, 639, 641, 643, 647, 649, 652, 653, 655, 661, 662, 664, 666, 667, 669, 673, 679, 681, 683, 685, 686, 687, 688, 691, 693, 694, 698, 701, 705, 709, 716, 718, 719, 721, 722, 724, 733, 734, 737, 739, 742, 743, 745, 746, 749, 751, 753, 754, 757, 758, 763, 764, 765, 766, 769, 771, 772, 773, 778, 779, 781, 787, 789, 790, 794, 796, 797, 801, 802, 804, 805, 807, 808, 809, 811, 814, 815, 821, 823, 826, 827, 829, 830, 832, 834, 835, 838, 844, 845, 849, 852, 853, 856, 857, 859, 861, 862, 863, 864, 865, 869, 871, 872, 873, 875, 877, 879, 881, 883, 886, 887, 889, 892, 893, 907, 908, 911, 913, 914, 917, 919, 921, 922, 926, 927, 928, 929, 931, 932, 937, 939, 941, 942, 944, 945, 946, 947, 948, 949, 950, 951, 953, 954, 955, 956, 958, 964, 965, 967, 969, 970, 971, 972, 973, 974, 976, 977, 978, 979, 981, 983, 985, 988, 989, 991, 997, 998, 999, 1000]
#118, 61 (335_159_612) had an x of 300 something million lol

#had realization about using square roots... sqrt(d)*y = x - 1
#(x**2 - 1)... so just iterate through the divisors, not the integers has to be a divsor of D!! Reflect.


#NEW APPROACH
#x**2 - 1 has to have D as a divisor... so you can iterate through all the multiples of D, of what's left at least... check for each num if
#D multiple is x**2 -1, so add 1, then try to take square root
require 'benchmark'
Benchmark.measure{
@min_sols = []
the_346.each do |d|
  (100_000..1_000_000).each do |n| #because already went through a lot!
    #(x_sqrd - 1)  = (d*n) #get the d multiple and add 1 and that should be x_sqrd
    x_sqrd = (d*n) + 1
    x_pot = Math.sqrt(x_sqrd)
    if x_pot == x_pot.to_i #if there's a valid x for this value
      y_pot = Math.sqrt(((d*n)/(d.to_f)))
      if y_pot == y_pot.to_i
        @min_sols << [d, x_pot, y_pot]
        break #move onto next d value
      end
    end
  end
end
}



#produces 416 solutions (n .. 100_000) in 27 seconds, still better than the previous method!
#cranking to 1_000_000 products no bones still for the 346.


#iter comnplexity, a billion, 100_000_000, etc.
#hmm... x for some of these values are like 12 mill, so x**2 has thirteen digits... i.e. almost a trillion.
#I don't think we can do off of thge squared x values... numbers could reach a trill... need to do it off of x itself.
#need to take d values and generate potential list of x values.


#problem is trying to generate x**2 values... need to generate x proper values, if x**2 -1 must have d as a divisor... (to guarantee that y**2 is an integer)...
#d = 3
#x = 5... x**2 has 3 as divisor, and y**2 is 5. Bad answer because y needs to be positive.

#Possible approach:
#know based on the values of d which ones are going to have the ridiculously high x values... and then just run the brute force on the handful, shouldn't take too long.

#Possible approach:
#take a number of the solutions for the lesser numbers, scan them for some pattern recognition to predict waht the solutions will look like.

#Possible approach:
#can we figure out if the x solutions fall into certain ranges, so we can just iterate through those...? lots around the 300 mill mark...

#Possible approach:
#Y values are coming accross as a lot smaller.....so try to iterate from those... appear to be about one tenth as much
#possible issue, may not give the minimum x solution... but since y and x seem to increase somewhat linearly with eachother it just may...


#Y based
Benchmark.measure{
@min_sols = []
((2..1000).to_a - (2..32).to_a.map{|g| g**2} - d_arr).each do |d| #going to try all of them again...
  (1_000_000..10_000_000).each do |y| #because already went through a lot!
    #(x_sqrd - 1)  = (d*n) #get the d multiple and add 1 and that should be x_sqrd
    left = ((y**2)*d + 1) #should equal x**2
    left_sqrt = Math.sqrt(left) #or x
    if left_sqrt == left_sqrt.to_i
      @min_sols << [d, left_sqrt, y]
      break
    end
  end
end
}
#doing it to a million yield ___ solutions of the 969 ones that need values...
#doing 1 bill iter complexity (my upper limit.), can hopefully reduce to 100 and then do to 10 mill (same complexity)
#^148 secs --> 710 solutions.
#greatest value was 24 mill (of x) with a y just under 1 mill

#OK, x based gives results for some sooner than y based it looks like... maybe you have to do a combo on each iteration...? I can try a combined approach.



#y based gave: [[85, 285769.0, 30996]]
#x based gave: [[85, 216041742, 23433017.0]]

#based on this, we probably we want to redo it.


#X & Y combined... #switching to just y
Benchmark.measure{
@min_sols = []
#((2..1000).to_a - (2..32).to_a.map{|g| g**2} - d_arr - d2_arr).each do |d| #going to try all of them again...
#((2..1000).to_a - (2..32).to_a.map{|g| g**2}).each do |d|
[778].each do |d|
  (280_000_000..580_000_000).each do |y| #because already went through a lot!
    left = ((y**2)*d + 1) #should equal x**2
    left_sqrt = Math.sqrt(left) #or x
    if left_sqrt == left_sqrt.to_i
      if y > 3_000_000
        if ((left_sqrt**2) - d*(y**2)) == 1
          @min_sols << [d, left_sqrt, y] #changeing var name, careful
          break
        end
      else
        @min_sols << [d, left_sqrt, y] #changeing var name, careful
        break
      end
    end
  end
end
}
#issue with variables... or...? will bigdecimal make it absurdly slow?? or are solutions low enough that will succeed??
#where need bigdecimal... 12 million for y its still bad :(, 7 mill for y still too much... 5 mill checks out...

#2.. 1 mill how many solutions and how long it takes: 245s... 710 solutions... lol. so x does not solve any earlier.
#how many more than 710 will this produce? And how much longer than 147s?

#going from 710 solutions to try to get rest: 490s gives 35 solutions
#iterating 1 mill to 5 mill.... has a similar 1 bill complexity.
#but taking much, much, much longer than the 2..1 mill iterations... for the 969

the_223 = [97, 109, 139, 149, 151, 157, 163, 166, 181, 193, 199, 211, 214, 233, 241, 244, 253, 261, 262, 268, 271, 277, 281, 283, 298, 301, 307, 309, 313, 317, 331, 334, 337, 343, 349, 353, 358, 367, 379, 382, 394, 397, 409, 412, 419, 421, 431, 433, 436, 446, 449, 454, 457, 461, 463, 466, 477, 478, 481, 487, 489, 491, 493, 501, 502, 508, 509, 511, 517, 521, 523, 524, 526, 537, 538, 541, 547, 549, 553, 554, 556, 559, 562, 565, 569, 571, 581, 586, 589, 593, 596, 597, 599, 601, 604, 607, 610, 613, 614, 617, 619, 622, 628, 631, 633, 634, 637, 641, 643, 649, 652, 653, 655, 661, 662, 664, 669, 673, 679, 681, 683, 685, 686, 691, 694, 701, 709, 716, 718, 719, 721, 724, 733, 737, 739, 742, 746, 749, 751, 753, 754, 757, 758, 763, 764, 766, 769, 771, 772, 773, 778, 787, 789, 790, 794, 796, 797, 801, 802, 805, 809, 811, 814, 821, 823, 826, 829, 834, 835, 838, 844, 845, 849, 853, 856, 857, 859, 861, 862, 863, 865, 869, 871, 877, 881, 883, 886, 889, 893, 907, 911, 913, 917, 919, 921, 922, 926, 928, 929, 931, 932, 937, 941, 946, 947, 949, 951, 953, 955, 956, 965, 967, 971, 972, 974, 976, 977, 981, 988, 989, 991, 997, 998]
#again, 61 has x of 335 mill
#thes substract perfectly... meaning all of the 223 are in the 346 array.


the_40 = [61, 109, 151, 199, 268, 271, 277, 281, 317, 331, 334, 367, 454, 461, 478, 489, 491, 501, 517, 523, 538, 597, 617, 652, 653, 673, 709, 754, 778, 796, 797, 829, 849, 883, 889, 907, 921, 949, 967, 971]
#third attempt with the y... trying to get the remaining low... 5mil to 30mil
#1638s and 184 solutions!
#greates x is 823_604_599 [917, 823604599.0, 27197820]

#fourth attempt just the 40! yippee....
#@real=150.730295, 38 sols!
#617 and 778 are the ones left...
[[61, 335159612.0, 42912791], [109, 372326272.0, 35662389], [151, 498062163.0, 40531724], [199, 640500731.0, 45403893], [268, 534917633.0, 32675295], [271, 667137236.0, 40525701], [277, 567444389.0, 34094429], [281, 606183385.0, 36161869], [317, 577590652.0, 32440723], [331, 770394803.0, 42344728], [334, 587510696.0, 32147155], [367, 605024944.0, 31582045], [454, 650308390.0, 30520485], [461, 959700061.0, 44697688], [478, 801567695.0, 36662853], [489, 707974023.0, 32015692], [491, 725489305.0, 32740874], [501, 673773097.0, 30101962], [517, 1110550906.0, 48841973], [523, 699903701.0, 30604652], [538, 739950864.0, 31901547], [597, 1032014507.0, 42237542], [652, 1074439109.0, 42078283], [653, 775384979.0, 30343159], [673, 958168334.0, 36934675], [709, 941951603.0, 35375735], [754, 836977699.0, 30480930], [796, 1196442047.0, 42406764], [797, 1216797167.0, 43101167], [829, 879672881.0, 30552302], [849, 888102911.0, 30479613], [883, 1186224595.0, 39919636], [889, 994414235.0, 33351583], [907, 1028830619.0, 34161760], [921, 1114256834.0, 36716011], [949, 1016454459.0, 32995508], [967, 1114540897.0, 35841219], [971, 991706964.0, 31825391]]

#last two...
[[617, 1592796237.0, 64123562], [778, 2178548422.0, 78104745]] #an x of 2 billion... y of 78 mill...

#running the algo all at once takes 40 minutes.

#DAMN IT. DOESNT WORK BECAUSE RUBY sqrt(num) != sqrt(num)**2 under certain situations... wtf


#only 740 make it... the rest have the screwy too large to be accurate issue...
#the 229 that are killing me :(...
the_229 = [149, 157, 181, 193, 199, 211, 214, 233, 241, 244, 253, 268, 271, 277, 281, 283, 298, 301, 309, 313, 317, 331, 334, 337, 343, 349, 353, 358, 367, 379, 382, 394, 397, 409, 412, 419, 421, 431, 433, 436, 446, 449, 454, 457, 461, 463, 466, 477, 478, 481, 487, 489, 491, 493, 501, 502, 508, 509, 511, 517, 521, 523, 524, 526, 537, 538, 541, 547, 549, 553, 554, 556, 559, 562, 565, 566, 569, 571, 581, 586, 589, 593, 596, 597, 599, 601, 604, 607, 610, 613, 614, 617, 619, 622, 628, 629, 631, 633, 634, 637, 641, 643, 647, 649, 652, 653, 655, 661, 662, 664, 667, 669, 673, 679, 681, 683, 685, 686, 691, 694, 701, 709, 716, 718, 719, 721, 724, 733, 737, 739, 742, 746, 749, 751, 753, 754, 757, 758, 763, 764, 766, 769, 771, 772, 773, 778, 787, 789, 790, 794, 796, 797, 801, 802, 805, 809, 811, 814, 821, 823, 826, 829, 834, 835, 838, 844, 845, 849, 853, 856, 857, 859, 861, 862, 863, 865, 869, 871, 877, 879, 881, 883, 886, 889, 893, 907, 911, 913, 917, 919, 921, 922, 926, 928, 929, 931, 932, 937, 941, 946, 947, 949, 951, 953, 955, 956, 958, 964, 965, 967, 970, 971, 972, 974, 976, 977, 981, 988, 989, 991, 997, 998, 999]
#109... went up to 2 billion, no cheese. LOL LOL FUCK.
#ome back group...

Benchmark.measure{
@new_sols = []
#((2..1000).to_a - (2..32).to_a.map{|g| g**2} - d_arr - d2_arr).each do |d| #going to try all of them again...
#((2..1000).to_a - (2..32).to_a.map{|g| g**2}).each do |d|
the_229.each do |d|
  (3_000_000..200_000_000).each do |y| #because already went through a lot!
    left = ((y**2)*d + 1) #should equal x**2
    left_sqrt = Math.sqrt(left) #or x
    next if left_sqrt.floor**2 != left #thank you internet!
    if left_sqrt == left_sqrt.to_i
      #if y > 3_000_000
        #if ((left_sqrt**2) - d*(y**2)) == 1
          @new_sols << [d, left_sqrt, y] #changeing var name, careful
          puts "got one #{d}"
          break
        #end
      #else
      #  @new_sols << [d, left_sqrt, y] #changeing var name, careful
      #  break
     # end
    end
  end
end
}

#new method... [[261, 192119201.0, 11891880], [262, 104980517.0, 6485718], [61, 1766319049.0, 226153980], [151, 1728148040.0, 140634693], [166, 1700902565.0, 132015642]]

#impercions with sqrt of really large numbers, known issue:
#cause sqrt returns a Float and its prescision will not suffice here. I would advice you to implement your own sqrt function. T
#here are several algorithms out there suggesting how to do that, but I personally thing using a binary search for computing the reverse for a fucntion is the easiest:

#borrowing from stack overflow to get sqrt more precise!

# def sqrt a
#   begv = 1
#   endv = a
#   while endv > begv + 1
#      mid = (endv + begv)/2
#      if mid ** 2 <= a
#         begv = mid
#      else
#         endv = mid
#      end
#   end
#   return begv
# end

#PEll's equation
#can refactor to  (x + y*sqrt d)(x - y*sqrt d) = 1.; have to expand it like that because of the +/- stuff that happens when do sqrt's

#have to do BigDecimal for the sqrt's... will have to do an approx round with a to_i...
#just use the big ones we've narrowed it down to.
#Can use that equat to try to get it close... if it's within 300 of 1, then perform the brute force...
#could lead with y, since tends to eb smaller in value.

#why does dreamshire only take the primes when doing this?



#67################################################

#the triange question has the complexity of 2**n, where n is the number of rows... multiply all the possiblities by two as you go down. So again... 2^99 possibilities...
#but there is a solution where you can start from the bottom and work your way north...
#if you take the row above the bototm row and just add the biggest number, so we'll create a new array and then put it back into the function to take the row -2 from last and
#compare the index positions to get the biggest value.
#board



def collapse_row board
  last, second_last = board[-1], board[-2]
  second_last.each_with_index.map do |num, i|
    second_last += last[i-1].nil? last[i] ? [last[i], last[i-1]].max
  end
  board.pop
  collapse_row board
end

collapse_row board

@board = @board.split("\n").map{|f| f.split(" ")}.map{|f| f.map(&:to_i)}
def collapse_row
  return if @board.size == 2
  @board[-2] = @board[-2].each_with_index.map{ |num, i|  num += [@board[-1][i], @board[-1][i-1]].max }
  @board.pop
  collapse_row
end

collapse_row

#while loop alsi makes sense
@board = @board.split("\n").map{|f| f.split(" ")}.map{|f| f.map(&:to_i)}
while @board.size > 1
  @board[-2] = @board[-2].each_with_index.map{ |num, i|  num += [@board[-1][i], @board[-1][i+1]].max }
  @board.pop
end


#69################################################
#interesting problem because I know how I can solve it, but... its just too slow...
#concept of being relatively prime... you're just not a divser of the number you're relatively prime to.
#then take the num, and divide it by the num of relatively prime ones...
#STEP 1, array for numbers up to one million of the number of relative primes
#STEP 2, map that array to get the "Totient maximum"

#everyone has a 1 as a relatively prime.
@success = []
(10..1_000_000).each do |num| #know we can start at 10 because those arne't in answer anyways
  @num = num #storing refernecee to original number outside of the machine... this is your prime computing machine....
  @rel_primes = 1 #need to set the initila state for the machine
  set_rel_primes 2, num
  @success << @rel_primes
end

#this is a cool idea... but a rel prime can go way above what the divisor is... (can be 1 less than n...)
def get_rel_primes(start, num)
  (start..num).each do |n|
    if num % n != 0
      @rel_primes += 1
    else
      get_real_primes(n, (num/n))#if it divides, do the funciton from top with adjusted iter. range
    end
  end
end

#YES GOOD INSIGHT --> inefficient use of recursion.. .or?
#set up of seting up a really massive recursive stack but with no intention to return to earlier calls on the stack... going to return and abandon it all when you get the value...
#note when doing this, the code is only going to get run once below the reucrsive method call, so you can put your end logic there.



#alt approach...


#this is a cool idea... but a rel prime can go way above what the divisor is... (can be 1 less than n...)
#still can use it to get the divisors!
require 'benchmark'
Benchmark.measure{
#why does this execute more than once??
def get_rel_primes(start, num)
  (start..num).each_with_index do |n, i|
    if num % n == 0
      @divisors << n #for 10... 2,5
      get_rel_primes(n + 1, (num/n)) unless i == num - start #no, e  #smart to realize not to go anymore if it's on the last iteration, don't forget to plus 1 so start is not the same.
      break #dont forget to break... these arent as straightforward to strucutre as you think.
    end
  end
 # puts @divisors #why does it call it twice when clearly should only do it once?
  rel_primes = (2..(@num - 1)).to_a - @divisors.uniq  #shoudln't be num, should be original num before the recursion! #lets see if uniq makes a difference... NOPE

  @deletes = []
  rel_primes.each{ |rp| get_deletes 2, rp }

  #do processing so no common divisors are shared
  @rel_primes = (rel_primes - @deletes).size + 1 #plus 1 for the 1 value that we'll need.
  return #does this return from just the one function on the stack, or does it iterate through and now return from all of them????
end

def get_deletes(start,num)
  (start..num).each_with_index do |n,i|
    if num % n == 0 && @num % n == 0 # || (rp.even? && @num.even?) #take out evens if the @num is also even, wow that even check doubles the time...
      @deletes << num
      get_deletes(n+1, num/n) unless i == num - start
      return
    end
  end
end

#get everyting that divides into it evently, subtract the rest from the num array
@success = []
(6..10_000).each do |num| #know we can start at 10 because those arne't in answer anyways
  @num = num #yes you need this for further in, don't want to work with modified recursive num, want to work with original-original
  @divisors = []
  get_rel_primes 2, num
  @success << @rel_primes
end
}


#new method still really slow.... extremely fast for low numbers. ... still 1000: 36 seconds, lol
#may perform better as the main iterator gets higher due to the division algo... 10_000:



#lol this way costs 36 seconds to do a thousand... and it will be growing exponentially.

#NOTE, the ruby even? odd? are time consuming


#nice, but you have definiton of a relativel prime wrong, they have no common factors!

#too complex with the divisors check thing, should do the sleive set up for those?


#ALT APPROACH:

require 'benchmark'
Benchmark.measure{
def get_rel_primes(start, num)
  #because of the num/n this will ignore the 8 of the 10... so new approach....
  (start..num).each_with_index do |n, i|
    if @num % n == 0
      @divisors << n
      @divisors << (2..@num/n).map{|f| f*n}

      get_rel_primes(n + 1, (num/n)) unless i == num - start   #problem, this division will ignore the 8 (when 10) because doesnt iterate that high.
      break #
    end
  end
   @rel_primes = ((2..(num-1)).to_a - @divisors.flatten).size + 1 #see if we can cut this out.
  return
end

@success = []
@num_arr  = [2,3,4,5] #to optomize to avoid massive array subtractoin...?
[999983].each do |num|
  @num = num
  @divisors = []
  get_rel_primes 2, num
  @num_arr << num #so wont have last one
  @success << @rel_primes
end
}
#benchmark, 1000: .7...
#10_000: 84 sec. grows  ALOT slower as the # of em gets bigger. For the iter increase (h, *10) its time goes h**2
#taking out the extra divisors checking, its still really slow... 10_000: 16 sec.l 100_000: WAY TOO SLOW
#what's the bottleneck: array minusing the bottleneck?
#10_000 does 1 sec without the array minus and without the @divisors multipler; w/ the @divisors multi w/0 minus... 4.5... w/o multi + minus --> 16 sec... w multi w minus: 84 sec, lol
#the two multiplied
#bottleneck is the range generation of all the numbers and the to_a; or not the range generation, it's the subtraction of an array of distinct elements...? 8sec...
#its now 54 seconds with the @num_arr
#increase linearly? 20k, 108 s? ...


#another approach... only iterate over the numbers where we think there will be a large totient

#what about multiples of the n... can we determine what their quotient is already, or use existing gather data to narrow down?
#YES, if the @num has as a divisor other nums already iterated, add those nums to it!

#idea of iterating other way so can test if a divisor out there has already had some of its numbers set.
#but conflicts with iterating forward to do sleive stuff.

#preprocessing on main iter array to divide out things that are divisble by other number sin the array...
#stop the rel_primes calculating if number gets higher than the 3/1 ratio of num/rel_primes
#we know that all of them will have prime numbers that are less than them in their set, off the bat...



@prim_arr = Prime.take(100_000).select{|f| f < 1_000_000 }
#prime numbers have no divisors... if prive the totentien will be @num - 1

require 'prime'
require 'benchmark'
Benchmark.measure{
def get_rel_primes(start, num)
  #good idea sort of, but won't work bc cant stop after first divisor is found... have to go through all of them to add the divisor...
  #if go through and add all of them from all the divisors, it will be too much really?
  # (1..(num/2)).to_a.reverse.each do |p| #iterating backwards to see if already a divisor, and assigning @rel_primes... and a new iterator
  #   break if p < 6
  #   if num % p == 0
  #    # @existing = @success[p - 6] #because iteration starts at six
  #    # start = p + 1
  #     break
  #   end
  # end

  #because of the num/n this will ignore the 8 of the 10... so new approach....
  (start..num).each_with_index do |n, i|
    if @num % n == 0
      @divisors << n
      @divisors << (2..@num/n).map{|f| f*n} #those aren't necessarily divisors... ?

      get_rel_primes(n + 1, (num/n)) unless i == num - start   #problem, this division will ignore the 8 (when 10) because doesnt iterate that high.
      break #
    end
  end
  @rel_primes = (@num - @divisors.flatten.uniq.size)
  return
end

@success = []
#@num_arr  = [2,3,4,5] #to optomize to avoid massive array subtractoin...?
[390390, 510510, 570570, 667590, 690690, 746130, 788970, 833910, 870870, 881790, 903210, 930930, 985530].each do |num|
  @num = num
  @existing = 0
  # if num.prime?
  #   @success << (num - 1)
  #   next  #removes 70,000 primes... only about a tenth of what needs ot be iterated.
  # end
  @divisors = []
  get_rel_primes 2, num
  #so wont have last one
  @success << [@rel_primes, @num, @num/@rel_primes.to_f]
end
}

#with this 20k is now... 25 seonds..
#100k is now... 651 secs... x 5 iter-size, x 25 complex... so x 10 to get to a million will be x 100, so 6,510 s... so 100 minutes-ish.
#the priem? speeds it up, definitely
#20 (from 25, when subtract sizes not the arrays)... 521 for 100_000


#new approach
#there are patterns here... 500_000 and 50_000 have same ratio... could that be same for num x 10, etc?
#once you get into the 100s... you can take out a LOT. --> something that ends with a zero, all it's others that end with zeros can be taken out...


@main_iters = (7..1_000_000).reject{ |f| f.prime? || f.odd? || f.to_s[-2..-1] == "00" }
@main_iters = @main_iters.select{ |f| f % 3 == 0 && f % 5 == 0 } #down to 163k
@main_iters = @main_iters.reject{ |f| @main_iters.include?(f/2.0) || @main_iters.include?(f/3.0) || @main_iters.include?(f/5.0)} #unsure about the whole multiple thing...
#lets try this 1270 group.. .lets work out the faster algorith!

require 'prime'
require 'benchmark'
Benchmark.measure{
def get_rel_primes(start, num)
  (start..num).each_with_index do |n, i|
    next if n % 2 == 0 || n % 3 == 0 || n % 5 == 0
    if @num % n == 0
      @pure_divisors << n if @pure_divisors.none?{ |f| n % f == 0 }

      get_rel_primes(n + 1, (num/n)) unless i == num - start
      break
    end
  end
  @rel_primes = (@num - @pure_divisors.flatten.uniq.size) #- @divisor_multiples #to get rid of self! assuming it won't be there.
  return
end

#probably true that if divisible by small nums like 2,3,5, then you'll have a much higher ratio.

@success = []
(1..100_000).each do |num|
  @num = num
  @pure_divisors = [2,3,5]
 # @divisor_multiples = ((num/2 - 2) + (num/3 - 2) + (num/5 - 2)) - ((num/6 - 2) +  (num/10 - 2) + (num/15 - 2))#NO! will cross over. #safe to assume if divisble by both 2 and 5, will be divis by 10...
  get_rel_primes 7, num/5
  @success << [@pure_divisors, @rel_primes, @num, @num/@rel_primes.to_f]
end
}


#ALSO: since doesnt ask what the ratio is... just get the highest ratio (leave all the extra 2's and 4's and stuff in there, will be the same for all.)

#can assume whoever has the most pure divisors wins?

#if num is divisible by anything

#if you double a number, it will have double to amounts...
#rather... if one number is divisble by another, then get rid of the bigge rnumber!




#ah, my hopefuls...
[390390, 510510, 570570, 667590, 690690, 746130, 788970, 833910, 870870, 881790, 903210, 930930, 985530]


#logic here is start with primes and multiply up (opposite factorial), becaus eyou know that number will be divisible by all those primes.
#the lowest prime means, yes, it will have less relative primes, because more instances of that number less than the num...
# can solve with Prime.take(7).inject(&:*)






#70################################################
#get all the totients like the above... but here you have to figure out what the rel prime count is for each number (so actually doing the above and calculating the rel_primes)
#have to do that so you can know if there's a permutation or not...
#has to be same digits, that's true.










