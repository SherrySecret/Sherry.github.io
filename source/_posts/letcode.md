---
title: letcode
date: 2024-06-16 12:32:45
tags:
password: 123456
---

# LeetCode题库

## 1.两数之和

### 题干

给定一个整数数组 nums 和一个整数目标值 target，请你在该数组中找出 和为目标值 target  的那 两个 整数，并返回它们的数组下标。

你可以假设每种输入只会对应一个答案。但是，数组中同一个元素在答案里不能重复出现。

你可以按任意顺序返回答案。

 

示例 1：

**输入：**nums = [2,7,11,15], target = 9
**输出：**[0,1]
**解释：**因为 nums[0] + nums[1] == 9 ，返回 [0, 1] 。
示例 2：

**输入：**nums = [3,2,4], target = 6
**输出：**[1,2]
示例 3：

**输入：**nums = [3,3], target = 6
**输出：**[0,1]

**提示：**

2 <= nums.length <= 104
-109 <= nums[i] <= 109
-109 <= target <= 109
只会存在一个有效答案

### 解法

#### 1. 穷举法

**思路**：通过for循环确定数组中是否有target-x，两层循环令i和j逐步后移，找到目标返回数组下标，反之返回数组0。

```java
class Solution {
    public int[] twoSum(int[] nums, int target) {
        int n=nums.length;
        for(int i=0;i<n;++i)
        {
            for(int j=i+1;j<n;++j)
            {
                if(nums[j]==target-nums[i])
                return new int[]{i,j};
            }
        }
        return new int[0];
    }
}

```



**时间复杂度：** *O（n²）* 最坏的情况每个元素都要与其它元素比对。

**空间复杂度：** *O（1 ）*

#### 2. 哈希表

**思路：** 在每一层循环中，都在哈希表中寻找是否有对应元素的目标值，若没有，则加入表中，反之，输出结果即可，以空间减少时间耗费。以此来降低时间复杂度，解决时间复杂度较高的bug。

```java
class Solution {
    public int[] twoSum(int[] nums, int target) {
        int n=nums.length;
        Map<Integer, Integer> hashtbl = new HashMap<Integer, Integer>();
        for(int i=0;i<n;i++)
        {
            if(hashtbl.containsKey(target-nums[i]))
            {
                return new int[]{hashtbl.get(target-nums[i]),i};
            }
            hashtbl.put(nums[i],i);
        }
        return new int[]{0};
    }
}
```

**时间复杂度：** *O（n）*

**空间复杂度：** *O（n）*











## 2.两数相加

### 题干

给你两个 非空 的链表，表示两个非负的整数。它们每位数字都是按照 逆序 的方式存储的，并且每个节点只能存储 一位 数字。

请你将两个数相加，并以相同形式返回一个表示和的链表。

你可以假设除了数字 0 之外，这两个数都不会以 0 开头。

示例 1：


输入：l1 = [2,4,3], l2 = [5,6,4]
输出：[7,0,8]
解释：342 + 465 = 807.
示例 2：

输入：l1 = [0], l2 = [0]
输出：[0]
示例 3：

输入：l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]
输出：[8,9,9,9,0,0,0,1]


提示：

每个链表中的节点数在范围 [1, 100] 内
0 <= Node.val <= 9
题目数据保证列表表示的数字不含前导零

### 解法

#### 模拟法

**思路**： 由于输入的两个链表都是逆序存储数字的位数的，因此两个链表中同一位置的数字可以直接相加。

我们同时遍历两个链表，逐位计算它们的和，并与当前位置的进位值相加。具体而言，如果当前两个链表处相应位置的数字为 n1,n2n1,n2，进位值为 carry，则它们的和为n1+n2+carry

如果两个链表的长度不同，则可以认为长度短的链表的后面有若干个 0。

此外，如果链表遍历结束后，有carry>0，还需要在答案链表的后面附加一个节点，节点的值为 carry。

```java
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode() {}
 *     ListNode(int val) { this.val = val; }
 *     ListNode(int val, ListNode next) { this.val = val; this.next = next; }
 * }
 */
class Solution {
    public ListNode addTwoNumbers(ListNode l1, ListNode l2) {
        ListNode head=null,tail=null;
        int carry=0;
        int sum=0;
        while(l1!=null||l2!=null)
        {
            int n1 = l1 != null ? l1.val : 0;
            int n2 = l2 != null ? l2.val : 0;
            sum=n1+n2+carry;
            if(head==null)
            {
                head=tail=new ListNode(sum%10);
            }
            else
            {
                tail.next=new ListNode(sum%10);
                tail=tail.next;
            }
            if(l1!=null)
            {
                l1=l1.next;
            }
           if(l2!=null)
            {
                l2=l2.next;
            }
            carry=sum/10;
        }
        if(carry>0)
        {
            tail.next=new ListNode(carry);
        }
        
        return head;
    }
}
```

**时间复杂度：***O（max(m,n)）*

**空间复杂度：***O（max(m,n)）*

m,n为两个链表的长度。

## 3.无重复字符的最长子串

### 题干

给定一个字符串 s ，请你找出其中不含有重复字符的 最长子串 的长度。

 

**示例 1:**

输入: s = "abcabcbb"
输出: 3 
解释: 因为无重复字符的最长子串是 "abc"，所以其长度为 3。

**示例 2:**

输入: s = "bbbbb"
输出: 1
解释: 因为无重复字符的最长子串是 "b"，所以其长度为 1。

**示例 3:**

输入: s = "pwwkew"
输出: 3
解释: 因为无重复字符的最长子串是 "wke"，所以其长度为 3。
     请注意，你的答案必须是 子串 的长度，"pwke" 是一个子序列，不是子串。



***提示：***

0 <= s.length <= 5 * 104
s 由英文字母、数字、符号和空格组成



### 解法

#### 滑动窗口

**思路：**由于要找字符串中的最长子串的长度，因此需要每次加入一个字符且统计此时的长度，并引入max不断更新最大值。联想到第一题所用的哈希表，在此处建立一个有Character和Integer组成的哈希表，记录每次加入的字符和其序号索引，每次加入一个字符便进行一次判断，哈希表中是否有新字符的重复项，若有，则将左指针直接指向右指针的下一位字符，继续进行寻找，每轮循环更新max，start，end值，最终return max即得以求解。

```java
class Solution {
    public int lengthOfLongestSubstring(String s) {
        Map<Character,Integer>map=new HashMap<Character,Integer>();
        int n=s.length();
        int start=0,end=0,max=0;
        for(end=0;end<n;++end)
        {
            char ch=s.charAt(end);
            if(map.containsKey(ch))
            {
                start=Math.max(map.get(ch)+1,start);
            }
            max=Math.max(max,end-start+1);
            map.put(ch,end);
        } 
        return max;
    }
}
```

**时间复杂度： ** *O（N）*字符串长度为N，指针遍历整个字符串。

**空间复杂度：** *O（∣Σ∣）*其中 \SigmaΣ 表示字符集（即字符串中可以出现的字符），∣Σ∣ 表示字符集的大小。在本题中没有明确说明字符集，因此可以默认为所有 ASCII 码在 [0,128) 内的字符， ∣Σ∣=128。我们需要用到哈希集合来存储出现过的字符，而字符最多有 ∣Σ∣ 个，因此空间复杂度为 O(∣Σ∣)。



## 4.寻找两个正序数组的中位数

### 题干

给定两个大小分别为 m 和 n 的正序（从小到大）数组 nums1 和 nums2。请你找出并返回这两个正序数组的 中位数 。

算法的时间复杂度应该为 O(log (m+n)) 。

 

示例 1：

输入：nums1 = [1,3], nums2 = [2]
输出：2.00000
解释：合并数组 = [1,2,3] ，中位数 2
示例 2：

输入：nums1 = [1,2], nums2 = [3,4]
输出：2.50000
解释：合并数组 = [1,2,3,4] ，中位数 (2 + 3) / 2 = 2.5




提示：

nums1.length == m
nums2.length == n
0 <= m <= 1000
0 <= n <= 1000
1 <= m + n <= 2000
-10^6<= nums1[i], nums2[i] <= 10^6

### 解法

#### 快速排序

**思路：**先通过循环将两个数组连接，然后通过快速排序将合并的数组排列好，进而输出中位数。

**注意：**由于中位数存在两数之和的一半的情况，因此数组应定义为double等类型。

```java
class Solution {
    public double findMedianSortedArrays(int[] nums1, int[] nums2) {
        int m=nums1.length;
        int n= nums2.length;
        double[] nums3=new double [m+n];
        for(int i=0;i<m;++i)
        {
            nums3[i]=nums1[i];
        }
        for(int i=m;i<m+n;++i)
        {
            nums3[i]=nums2[i-m];
        }
        Quick_Sort(nums3,0,m+n-1);
        if((m+n)%2==0)
        {
            return ((nums3[(m+n)/2]+nums3[(m+n)/2-1])/2);
        }
        else
        {
            return nums3[(m+n-1)/2];
        }
    }
    void Quick_Sort(double []arr,int begin,int end){
    if(begin > end)
        return ;
    double tmp = arr[begin];
    int i = begin;
    int j = end;
    while(i != j){
        while(arr[j] >= tmp && j > i)
            j--;
        while(arr[i] <= tmp && j > i)
            i++;
        if(j > i){
            double t = arr[i];
            arr[i] = arr[j];
            arr[j] = t;
        }
    }
    arr[begin] = arr[i];
    arr[i] = tmp;
    Quick_Sort(arr, begin, i-1);
    Quick_Sort(arr, i+1, end);
}
}
```



快速排序的算法：

```java
void Quick_Sort(int []arr,int begin,int end){
    if(begin > end)
        return ;
    int tmp = arr[begin];
    int i = begin;
    int j = end;
    while(i != j){
        while(arr[j] >= tmp && j > i)
            j--;
        while(arr[i] <= tmp && j > i)
            i++;
        if(j > i){
            int t = arr[i];
            arr[i] = arr[j];
            arr[j] = t;
        }
    }
    arr[begin] = arr[i];
    arr[i] = tmp;
    Quick_Sort(arr, begin, i-1);
    Quick_Sort(arr, i+1, end);
}
```



# 数据结构

## 第一天

### 217.存在重复元素

#### 题干

给你一个整数数组 nums 。如果任一值在数组中出现 至少两次 ，返回 true ；如果数组中每个元素互不相同，返回 false 。


示例 1：

输入：nums = [1,2,3,1]
输出：true
示例 2：

输入：nums = [1,2,3,4]
输出：false
示例 3：

输入：nums = [1,1,1,3,3,4,3,2,4,2]
输出：true


提示：

1 <= nums.length <= 105
-109 <= nums[i] <= 109

#### 解法

##### 1.哈希表

```java
class Solution {
    public boolean containsDuplicate(int[] nums) {
       Map<Integer, Integer> hashtbl = new HashMap<Integer, Integer>();
       int n=nums.length;
       for(int i=0;i<n;i++)
       {
           if(hashtbl.containsKey(nums[i]))
           {
               return true;
           }
           hashtbl.put(nums[i],i);
       }
       return false;

    }
}
```

- 时间复杂度：O*(*N)，其中 *N* 为数组的长度。
- 空间复杂度：O*(*N*)，其中 N* 为数组的长度。

##### 2.排序

```java
class Solution {
    public boolean containsDuplicate(int[] nums) {
        Arrays.sort(nums);
        int n=nums.length;
        for(int i=1;i<n;++i)
        {
            if(nums[i-1]==nums[i])
            {
                return true;
            }
        }
        return false;
    }
}
```

时间复杂度：O(NlogN)，其中 N 为数组的长度。需要对数组进行排序。

空间复杂度：O(logN)，其中 N 为数组的长度。注意我们在这里应当考虑递归调用栈的深度。

### 53.最大子数组和

#### 题干

给你一个整数数组 nums ，请你找出一个具有最大和的连续子数组（子数组最少包含一个元素），返回其最大和。

子数组 是数组中的一个连续部分。

 

示例 1：

输入：nums = [-2,1,-3,4,-1,2,1,-5,4]
输出：6
解释：连续子数组 [4,-1,2,1] 的和最大，为 6 。
示例 2：

输入：nums = [1]
输出：1
示例 3：

输入：nums = [5,4,-1,7,8]
输出：23


提示：

1 <= nums.length <= 105
-104 <= nums[i] <= 104


进阶：如果你已经实现复杂度为 O(n) 的解法，尝试使用更为精妙的 分治法 求解。

#### 解法

##### 贪心

```java
class Solution {
    public int maxSubArray(int[] nums) {
        int pre=0;
        int max=nums[0];
        for(int x:nums)
        {
            
            if(pre>0)
            {
                pre+=x;
            }
            if(pre<=0)
            {
                pre=x;
            }
            max=Math.max(pre,max);
        }
        return max;
    }
}
```



思路：遍历一次数组，记录当前和，之前和，最大和，若之前和不大于0，则舍弃，若大于0，则继续与下一个元素相加，每遍历一个元素就将当前和和最大和进行比较，实时更新最大值。dd

```java
拓展：
    for(int x :nums)
实际为foreach循环，循环次数与数组长度相同，每次循环的x与数组对应下标的元素相等。
```

时间复杂度：O(n)，其中 n 为 nums 数组的长度。我们只需要遍历一遍数组即可求得答案。
空间复杂度：O(1)，我们只需要常数空间存放若干变量。

##### 动态规划

```java
class Solution {
    public int maxSubArray(int[] nums) {
        int n=nums.length;
        for(int i=1;i<n;i++)
        {
            if(nums[i-1]>0)
            {
                nums[i]+=nums[i-1];
            }
            
           
        }
        Arrays.sort(nums);
        return nums[nums.length-1];
    }
}
```

思路：对每一个元素进行遍历，若前一个元素大于0，则将该元素与前一元素相加，元素实时根据是否相加进行更新，遍历完之后取新数组的最大值即为题干的解。

注意：最后的sort调用增加了此法的时间复杂度。

## 第二天

### 1.两数之和

见Leetcode题库第一题

### 88.合并两个有序数组

#### 题干

给你两个按 非递减顺序 排列的整数数组 nums1 和 nums2，另有两个整数 m 和 n ，分别表示 nums1 和 nums2 中的元素数目。

请你 合并 nums2 到 nums1 中，使合并后的数组同样按 非递减顺序 排列。

注意：最终，合并后数组不应由函数返回，而是存储在数组 nums1 中。为了应对这种情况，nums1 的初始长度为 m + n，其中前 m 个元素表示应合并的元素，后 n 个元素为 0 ，应忽略。nums2 的长度为 n 。

 

示例 1：

输入：nums1 = [1,2,3,0,0,0], m = 3, nums2 = [2,5,6], n = 3
输出：[1,2,2,3,5,6]
解释：需要合并 [1,2,3] 和 [2,5,6] 。
合并结果是 [1,2,2,3,5,6] ，其中斜体加粗标注的为 nums1 中的元素。
示例 2：

输入：nums1 = [1], m = 1, nums2 = [], n = 0
输出：[1]
解释：需要合并 [1] 和 [] 。
合并结果是 [1] 。
示例 3：

输入：nums1 = [0], m = 0, nums2 = [1], n = 1
输出：[1]
解释：需要合并的数组是 [] 和 [1] 。
合并结果是 [1] 。
注意，因为 m = 0 ，所以 nums1 中没有元素。nums1 中仅存的 0 仅仅是为了确保合并结果可以顺利存放到 nums1 中。


提示：

nums1.length == m + n
nums2.length == n
0 <= m, n <= 200
1 <= m + n <= 200
-109 <= nums1[i], nums2[j] <= 109

#### 解法

##### 先合并再排序

```java
class Solution {
    public void merge(int[] nums1, int m, int[] nums2, int n) {

        for(int i=0;i!=n;++i)
        {
            nums1[m+i]=nums2[i];
        }
        Arrays.sort(nums1);
    }
}
```

时间复杂度：O((m+n)log(m+n))。
排序序列长度为 m+nm+n，套用快速排序的时间复杂度即可，平均情况为O((m+n)log(m+n))。

空间复杂度：O(log(m+n))。
排序序列长度为 m+nm+n，套用快速排序的空间复杂度即可，平均情况为 O(log(m+n))。



## 第三天

#### 350.两个数组的交集Ⅱ

##### 题干

给你两个整数数组 nums1 和 nums2 ，请你以数组形式返回两数组的交集。返回结果中每个元素出现的次数，应与元素在两个数组中都出现的次数一致（如果出现次数不一致，则考虑取较小值）。可以不考虑输出结果的顺序。

 

示例 1：

输入：nums1 = [1,2,2,1], nums2 = [2,2]
输出：[2,2]
示例 2:

输入：nums1 = [4,9,5], nums2 = [9,4,9,8,4]
输出：[4,9]


提示：

1 <= nums1.length, nums2.length <= 1000
0 <= nums1[i], nums2[i] <= 1000


进阶：

如果给定的数组已经排好序呢？你将如何优化你的算法？
如果 nums1 的大小比 nums2 小，哪种方法更优？
如果 nums2 的元素存储在磁盘上，内存是有限的，并且你不能一次加载所有的元素到内存中，你该怎么办？



##### 解法

```java
class Solution {
    public int[] intersect(int[] nums1, int[] nums2) {
        Map<Integer, Integer> map = new HashMap<>();
        for(int num: nums1){
            int count=map.getOrDefault(num,0)+1;
            map.put(num,count);
        }
        ArrayList<Integer> list = new ArrayList<>();
        int index=0;
        int[] arr=new int[Math.max(nums1.length,nums2.length)];
        for(int num:nums2){
            int count=map.getOrDefault(num,0);
            if(count>0)
            {
                arr[index++]=num;
                count--;
                if(count>0)
                {
                    map.put(num,count);
                }else{
                    map.remove(num);
                }
            }
          
        }
        
        return Arrays.copyOfRange(arr,0,index);
    }
}
```

时间复杂度：O（m+n）

空间复杂度：O（min（m+n））

##### 补充

map.getOrDefault的用法：

[Java HashMap getOrDefault() 方法 | 菜鸟教程 (runoob.com)](https://www.runoob.com/java/java-hashmap-getordefault.html)



#### 121.买卖股票的最佳时机

##### 题干

给定一个数组 prices ，它的第 i 个元素 prices[i] 表示一支给定股票第 i 天的价格。

你只能选择 某一天 买入这只股票，并选择在 未来的某一个不同的日子 卖出该股票。设计一个算法来计算你所能获取的最大利润。

返回你可以从这笔交易中获取的最大利润。如果你不能获取任何利润，返回 0 。

 

示例 1：

输入：[7,1,5,3,6,4]
输出：5
解释：在第 2 天（股票价格 = 1）的时候买入，在第 5 天（股票价格 = 6）的时候卖出，最大利润 = 6-1 = 5 。
     注意利润不能是 7-1 = 6, 因为卖出价格需要大于买入价格；同时，你不能在买入前卖出股票。
示例 2：

输入：prices = [7,6,4,3,1]
输出：0
解释：在这种情况下, 没有交易完成, 所以最大利润为 0。


提示：

1 <= prices.length <= 105
0 <= prices[i] <= 104

##### 解法

###### 1.暴力遍历

~~~java
class Solution {
    public int maxProfit(int[] prices) {
        int res = 0;
        int n = prices.length;
        int pre = prices[0];
        for(int i = 1; i < n; i++){
            int cur = prices[i];
            if(cur < pre){
                pre = cur;
            } else if(cur > pre) {
                res = res>(cur-pre) ? res:(cur-pre);
            }
        }

        return res;
    }
}
~~~

时间复杂度：O（n²）

空间复杂度：O（1）

###### 2.动态规划

~~~java
class Solution {
    public int maxProfit(int[] prices) {
        int res = 0;
        int n = prices.length;
        int pre = prices[0];
        for(int i = 1; i < n; i++){
            int cur = prices[i];
            if(cur < pre){
                pre = cur;
            } else if(cur > pre) {
                res = res>(cur-pre) ? res:(cur-pre);
            }
        }

        return res;
    }
}
~~~

思路：遍历一次数组，没遍历一个数，将之与最小值作比较，小则更新，同时记录max的数值，即边找寻最小值，边计算最大的差值，最终的max即为返回的解。



时间复杂度：O（n）

时间复杂度：O（1）



## 第四天

### 566.重塑矩阵

#### 题干

在 MATLAB 中，有一个非常有用的函数 reshape ，它可以将一个 m x n 矩阵重塑为另一个大小不同（r x c）的新矩阵，但保留其原始数据。

给你一个由二维数组 mat 表示的 m x n 矩阵，以及两个正整数 r 和 c ，分别表示想要的重构的矩阵的行数和列数。

重构后的矩阵需要将原始矩阵的所有元素以相同的 行遍历顺序 填充。

如果具有给定参数的 reshape 操作是可行且合理的，则输出新的重塑矩阵；否则，输出原始矩阵。

 

示例 1：


输入：mat = [[1,2],[3,4]], r = 1, c = 4
输出：[[1,2,3,4]]
示例 2：


输入：mat = [[1,2],[3,4]], r = 2, c = 4
输出：[[1,2],[3,4]]


提示：

m == mat.length
n == mat[i].length
1 <= m, n <= 100
-1000 <= mat[i][j] <= 1000
1 <= r, c <= 300



#### 解法

~~~java
class Solution {
    public int[][] matrixReshape(int[][] mat, int r, int c) {
        int[][] ans=new int[r][c];
        int m=mat.length;
        int n=mat[0].length;
        if(m * n != r * c)
        {
            return mat;
        }
        for(int i=0;i<r*c;++i)
        {
            ans[i/c][i%c]=mat[i/n][i%n];
        }
        return ans;
    }
}
~~~

时间复杂度：O（rc）

空间复杂度：O（1）

### 118.杨辉三角

#### 题干

给定一个非负整数 numRows，生成「杨辉三角」的前 numRows 行。

在「杨辉三角」中，每个数是它左上方和右上方的数的和。

示例 1:

输入: numRows = 5
输出: [[1],[1,1],[1,2,1],[1,3,3,1],[1,4,6,4,1]]
示例 2:

输入: numRows = 1
输出: [[1]]


提示:

1 <= numRows <= 30

#### 解法

~~~java
class Solution {
    public List<List<Integer>> generate(int numRows) {

        List<List<Integer>> list=new ArrayList<List<Integer>>();
        for(int i=0;i<numRows;i++)
        {
            List<Integer>row =new ArrayList<Integer>();
            for(int j=0;j<=i;j++)
            {
                if(j==0||j==i)
                {
                    row.add(1);
                }
                else{
                    row.add(list.get(i-1).get(j-1)+list.get(i-1).get(j));
                }
                
            }
            list.add(row);
        }
        return list;
    }
}
~~~

时间复杂度：O（numRows²）

空间复杂度：O（1）



## 第五天

### 36.有效的数组

#### 题干

请你判断一个 9 x 9 的数独是否有效。只需要 根据以下规则 ，验证已经填入的数字是否有效即可。

数字 1-9 在每一行只能出现一次。
数字 1-9 在每一列只能出现一次。
数字 1-9 在每一个以粗实线分隔的 3x3 宫内只能出现一次。（请参考示例图）


注意：

一个有效的数独（部分已被填充）不一定是可解的。
只需要根据以上规则，验证已经填入的数字是否有效即可。
空白格用 '.' 表示。


示例 1：


输入：board = 
[["5","3",".",".","7",".",".",".","."]
,["6",".",".","1","9","5",".",".","."]
,[".","9","8",".",".",".",".","6","."]
,["8",".",".",".","6",".",".",".","3"]
,["4",".",".","8",".","3",".",".","1"]
,["7",".",".",".","2",".",".",".","6"]
,[".","6",".",".",".",".","2","8","."]
,[".",".",".","4","1","9",".",".","5"]
,[".",".",".",".","8",".",".","7","9"]]
输出：true
示例 2：

输入：board = 
[["8","3",".",".","7",".",".",".","."]
,["6",".",".","1","9","5",".",".","."]
,[".","9","8",".",".",".",".","6","."]
,["8",".",".",".","6",".",".",".","3"]
,["4",".",".","8",".","3",".",".","1"]
,["7",".",".",".","2",".",".",".","6"]
,[".","6",".",".",".",".","2","8","."]
,[".",".",".","4","1","9",".",".","5"]
,[".",".",".",".","8",".",".","7","9"]]
输出：false
解释：除了第一行的第一个数字从 5 改为 8 以外，空格内其他数字均与 示例1 相同。 但由于位于左上角的 3x3 宫内有两个 8 存在, 因此这个数独是无效的。


提示：

board.length == 9
board[i].length == 9
board[i][j] 是一位数字（1-9）或者 '.'

#### 题解

~~~c++
class Solution {
public:
    bool isValidSudoku(vector<vector<char>>& board) {
        int row[9][10]={0};
        int col[9][10]={0};
        int box[9][10]={0};
        for(int i=0;i<9;i++)
        {
            for(int j=0;j<9;j++)
            {
                int num=board[i][j]-'0';
                if(board[i][j]=='.') continue;
                if(row[i][num]) return false;
                if(col[j][num]) return false;
                int temp=j/3+i/3*3;
                if(box[temp][num]) return false;
                row[i][num]=1;
                col[j][num]=1;
                box[temp][num]=1;
            }
        }
        return true;

    }
};
~~~

时间复杂度：O（1）

空间复杂度：O（2）

重点：**temp=j/3+i/3**

# Leetcode75

## Leve1

### 第一天

#### 1480.一维数组的动态和

给你一个数组 nums 。数组「动态和」的计算公式为：runningSum[i] = sum(nums[0]…nums[i]) 。

请返回 nums 的动态和。

 

示例 1：

输入：nums = [1,2,3,4]
输出：[1,3,6,10]
解释：动态和计算过程为 [1, 1+2, 1+2+3, 1+2+3+4] 。
示例 2：

输入：nums = [1,1,1,1,1]
输出：[1,2,3,4,5]
解释：动态和计算过程为 [1, 1+1, 1+1+1, 1+1+1+1, 1+1+1+1+1] 。
示例 3：

输入：nums = [3,1,2,10,1]
输出：[3,4,6,16,17]

```go
func runningSum(nums []int) []int {
    for i:=1;i<len(nums);i++{
        nums[i]=nums[i-1]+nums[i]
    }
    return nums
}
```



#### 724.寻找数组的中心下标

给你一个整数数组 nums ，请计算数组的 中心下标 。

数组 中心下标 是数组的一个下标，其左侧所有元素相加的和等于右侧所有元素相加的和。

如果中心下标位于数组最左端，那么左侧数之和视为 0 ，因为在下标的左侧不存在元素。这一点对于中心下标位于数组最右端同样适用。

如果数组有多个中心下标，应该返回 最靠近左边 的那一个。如果数组不存在中心下标，返回 -1 。

 

示例 1：

输入：nums = [1, 7, 3, 6, 5, 6]
输出：3
解释：
中心下标是 3 。
左侧数之和 sum = nums[0] + nums[1] + nums[2] = 1 + 7 + 3 = 11 ，
右侧数之和 sum = nums[4] + nums[5] = 5 + 6 = 11 ，二者相等。
示例 2：

输入：nums = [1, 2, 3]
输出：-1
解释：
数组中不存在满足此条件的中心下标。
示例 3：

输入：nums = [2, 1, -1]
输出：0
解释：
中心下标是 0 。
左侧数之和 sum = 0 ，（下标 0 左侧不存在元素），
右侧数之和 sum = nums[1] + nums[2] = 1 + -1 = 0 。


提示：

1 <= nums.length <= 104
-1000 <= nums[i] <= 1000

##### 解法1

~~~go
func pivotIndex(nums []int) int{
    sum1:=0
    sum2:=0
    for i:=0;i<len(nums);i++{
        sum1,sum2=sums(nums,i)
        if(sum1==sum2){
            return i
        }
    }
    return -1
}
func sums(nums []int,i int) (int,int){
    left_sum:=0
    right_sum:=0
    for j:=0;j<i;j++{
        left_sum+=nums[j]
    }
    for l:=i+1;l<len(nums);l++{
        right_sum+=nums[l]
    }
    return left_sum,right_sum
}
~~~

**问题：时间复杂度较高**

##### 解法2.

~~~go
func pivotIndex(nums []int) int {
    total:=0
    for _,v:=range nums{
        total+=v
    }
    left_sum:=0
    for i,v:=range nums{
        if left_sum*2+v == total{
            return i
        }
        left_sum+=v
    }
    return -1
}
~~~

### 第二天

#### 205.同构字符串

给定两个字符串 s 和 t ，判断它们是否是同构的。

如果 s 中的字符可以按某种映射关系替换得到 t ，那么这两个字符串是同构的。

每个出现的字符都应当映射到另一个字符，同时不改变字符的顺序。不同字符不能映射到同一个字符上，相同字符只能映射到同一个字符上，字符可以映射到自己本身。

 

示例 1:

输入：s = "egg", t = "add"
输出：true
示例 2：

输入：s = "foo", t = "bar"
输出：false
示例 3：

输入：s = "paper", t = "title"
输出：true


提示：

1 <= s.length <= 5 * 104
t.length == s.length
s 和 t 由任意有效的 ASCII 字符组成

~~~go
func isIsomorphic(s string, t string) bool {

	m1 := map[byte]byte{}
	m2 := map[byte]byte{}
	for i := range s {
		x, y := s[i], t[i]
		if m1[x] > 0 && m1[x] != y || m2[y] > 0 && m2[y] != x {
			return false
		}
		m1[x] = y
		m2[y] = x
	}
	return true
}
~~~



#### 392.判断子序列

给定字符串 s 和 t ，判断 s 是否为 t 的子序列。

字符串的一个子序列是原始字符串删除一些（也可以不删除）字符而不改变剩余字符相对位置形成的新字符串。（例如，"ace"是"abcde"的一个子序列，而"aec"不是）。

进阶：

如果有大量输入的 S，称作 S1, S2, ... , Sk 其中 k >= 10亿，你需要依次检查它们是否为 T 的子序列。在这种情况下，你会怎样改变代码？

致谢：

特别感谢 @pbrother 添加此问题并且创建所有测试用例。

 

示例 1：

输入：s = "abc", t = "ahbgdc"
输出：true
示例 2：

输入：s = "axc", t = "ahbgdc"
输出：false


提示：

0 <= s.length <= 100
0 <= t.length <= 10^4
两个字符串都只由小写字符组成。

~~~go
func isSubsequence(s string, t string) bool {
    i:=0
    m,n:=len(s),len(t)
    j:=0
    for j<n &&i<m{
        if s[i]==t[j]{
            i++
        }
        j++
    }
    return i==m
}
~~~



### 第三天

#### 21.合并两个有序链表

将两个升序链表合并为一个新的 升序 链表并返回。新链表是通过拼接给定的两个链表的所有节点组成的。 

示例 1：


输入：l1 = [1,2,4], l2 = [1,3,4]
输出：[1,1,2,3,4,4]
示例 2：

输入：l1 = [], l2 = []
输出：[]
示例 3：

输入：l1 = [], l2 = [0]
输出：[0]


提示：

两个链表的节点数目范围是 [0, 50]
-100 <= Node.val <= 100
l1 和 l2 均按 非递减顺序 排列
通过次数1,242,167提交次数1,866,989

##### 法1.递归

~~~go
/**
 * Definition for singly-linked list.
 * type ListNode struct {
 *     Val int
 *     Next *ListNode
 * }
 */
func mergeTwoLists(l1 *ListNode, l2 *ListNode) *ListNode {
    l3 :=&ListNode{}
    if l1 == nil{
        return l2
    } 
    if l2 == nil {
        return l1
    }
    if l1.Val >= l2.Val{
        l3=l2
        l3.Next =mergeTwoLists(l1,l2.Next)
    } else {
        l3=l1
        l3.Next = mergeTwoLists(l1.Next,l2)
    }
    return l3
}
~~~

#### 法2.迭代

~~~go
func mergeTwoLists(l1 *ListNode, l2 *ListNode) *ListNode {
    dummyHead := &ListNode{}
    prev := dummyHead
    for l1 !=nil &&l2!=nil{
        if l1.Val >= l2.Val{
            prev.Next=l2
            l2=l2.Next
        } else {
            prev.Next=l1
            l1=l1.Next
        }
        prev=prev.Next
    }
    if l1 != nil{
        prev.Next=l1
    } 
    if l2 != nil {
        prev.Next=l2
    }
    
    return dummyHead.Next
}
~~~



#### 206.反转链表

你单链表的头节点 head ，请你反转链表，并返回反转后的链表。


示例 1：


输入：head = [1,2,3,4,5]
输出：[5,4,3,2,1]
示例 2：


输入：head = [1,2]
输出：[2,1]
示例 3：

输入：head = []
输出：[]


提示：

链表中节点的数目范围是 [0, 5000]
-5000 <= Node.val <= 5000

~~~go
/**
 * Definition for singly-linked list.
 * type ListNode struct {
 *     Val int
 *     Next *ListNode
 * }
 */
func reverseList(head *ListNode) *ListNode {
    var prev *ListNode
    for head != nil{
        temp:=head.Next
        head.Next=prev
        prev=head
        head=temp
    }
    return prev
}
~~~



### 第四天

#### 876.链表的中间结点

给定一个头结点为 head 的非空单链表，返回链表的中间结点。

如果有两个中间结点，则返回第二个中间结点。

 

示例 1：

输入：[1,2,3,4,5]
输出：此列表中的结点 3 (序列化形式：[3,4,5])
返回的结点值为 3 。 (测评系统对该结点序列化表述是 [3,4,5])。
注意，我们返回了一个 ListNode 类型的对象 ans，这样：
ans.val = 3, ans.next.val = 4, ans.next.next.val = 5, 以及 ans.next.next.next = NULL.
示例 2：

输入：[1,2,3,4,5,6]
输出：此列表中的结点 4 (序列化形式：[4,5,6])
由于该列表有两个中间结点，值分别为 3 和 4，我们返回第二个结点。


提示：

给定链表的结点数介于 1 和 100 之间。

~~~go
/**
 * Definition for singly-linked list.
 * type ListNode struct {
 *     Val int
 *     Next *ListNode
 * }
 */
func middleNode(head *ListNode) *ListNode {
    slow:=head
    fast:=head
    for fast!=nil && fast.Next!=nil{
        slow=slow.Next
        fast=fast.Next.Next
    }
    return slow
}
~~~



#### 142.环形链表Ⅱ

给定一个链表的头节点  head ，返回链表开始入环的第一个节点。 如果链表无环，则返回 null。

如果链表中有某个节点，可以通过连续跟踪 next 指针再次到达，则链表中存在环。 为了表示给定链表中的环，评测系统内部使用整数 pos 来表示链表尾连接到链表中的位置（索引从 0 开始）。如果 pos 是 -1，则在该链表中没有环。注意：pos 不作为参数进行传递，仅仅是为了标识链表的实际情况。

不允许修改 链表。

 

示例 1：

输入：head = [3,2,0,-4], pos = 1
输出：返回索引为 1 的链表节点
解释：链表中有一个环，其尾部连接到第二个节点。

示例 2：

输入：head = [1,2], pos = 0
输出：返回索引为 0 的链表节点
解释：链表中有一个环，其尾部连接到第一个节点。

示例 3：

输入：head = [1], pos = -1
输出：返回 null
解释：链表中没有环。



~~~go
func detectCycle(head *ListNode) *ListNode {
    read := map[*ListNode]struct{}{}
    for head != nil {
        if _, ok := read[head]; ok {
            return head
        }
        read[head] = struct{}{}
        head = head.Next
    }
    return nil
}
~~~



### 第五天

#### 121.买卖股票的最佳时机

给定一个数组 prices ，它的第 i 个元素 prices[i] 表示一支给定股票第 i 天的价格。

你只能选择 某一天 买入这只股票，并选择在 未来的某一个不同的日子 卖出该股票。设计一个算法来计算你所能获取的最大利润。

返回你可以从这笔交易中获取的最大利润。如果你不能获取任何利润，返回 0 。

 

示例 1：

输入：[7,1,5,3,6,4]
输出：5
解释：在第 2 天（股票价格 = 1）的时候买入，在第 5 天（股票价格 = 6）的时候卖出，最大利润 = 6-1 = 5 。
     注意利润不能是 7-1 = 6, 因为卖出价格需要大于买入价格；同时，你不能在买入前卖出股票。
示例 2：

输入：prices = [7,6,4,3,1]
输出：0
解释：在这种情况下, 没有交易完成, 所以最大利润为 0。


提示：

1 <= prices.length <= 105
0 <= prices[i] <= 104



~~~go
func maxProfit(prices []int) int {
    var min = prices[0]
    var profit int
    for _, price := range prices[1:] {
        if profit < price - min {
            profit = price - min
        }
        if min > price {
            min = price
        }
    }
    return profit
}
~~~



#### 409.最长回文串

给定一个包含大写字母和小写字母的字符串 s ，返回 通过这些字母构造成的 最长的回文串 。

在构造过程中，请注意 区分大小写 。比如 "Aa" 不能当做一个回文字符串。

 

示例 1:

输入:s = "abccccdd"
输出:7
解释:
我们可以构造的最长的回文串是"dccaccd", 它的长度是 7。
示例 2:

输入:s = "a"
输入:1
示例 3：

输入:s = "aaaaaccc"
输入:7
提示:

1 <= s.length <= 2000
s 只由小写 和/或 大写英文字母组成



~~~go
func longestPalindrome(s string) int {
	hash := map[byte]int{}
	for i := 0; i < len(s); i++ {
		hash[s[i]]++
	}
	res := 0
	for _, v := range hash {
		if v&1 == 1 {
			res += v - 1
		} else {
			res += v
		}
	}
	if res<len(s) {
		res++
	}
	return res
}
~~~



### 第八天

#### 98.验证二叉搜索树

给你一个二叉树的根节点 root ，判断其是否是一个有效的二叉搜索树。

有效 二叉搜索树定义如下：

节点的左子树只包含 小于 当前节点的数。
节点的右子树只包含 大于 当前节点的数。
所有左子树和右子树自身必须也是二叉搜索树。


示例 1：


输入：root = [2,1,3]
输出：true
示例 2：


输入：root = [5,1,4,null,null,3,6]
输出：false
解释：根节点的值是 5 ，但是右子节点的值是 4 。


提示：

树中节点数目范围在[1, 104] 内
-231 <= Node.val <= 231 - 1

~~~go
/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func isValidBST(root *TreeNode) bool {
    stack:=[]*TreeNode{}
    num:=math.MinInt64
    for len(stack)!=0||root!=nil {
        for root!=nil{
            stack=append(stack,root)
            root = root.Left
        }
        root = stack[len(stack)-1]
        stack = stack[0:len(stack)-1]
        if root.Val <= num {
            return false
        }
        num =root.Val
        root=root.Right
    }
    return true
}
~~~



#### 235.二叉搜索树的最近公共祖先

给定一个二叉搜索树, 找到该树中两个指定节点的最近公共祖先。

百度百科中最近公共祖先的定义为：“对于有根树 T 的两个结点 p、q，最近公共祖先表示为一个结点 x，满足 x 是 p、q 的祖先且 x 的深度尽可能大（一个节点也可以是它自己的祖先）。”

例如，给定如下二叉搜索树:  root = [6,2,8,0,4,7,9,null,null,3,5]



 

示例 1:

输入: root = [6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 8
输出: 6 
解释: 节点 2 和节点 8 的最近公共祖先是 6。
示例 2:

输入: root = [6,2,8,0,4,7,9,null,null,3,5], p = 2, q = 4
输出: 2
解释: 节点 2 和节点 4 的最近公共祖先是 2, 因为根据定义最近公共祖先节点可以为节点本身。


说明:

所有节点的值都是唯一的。
p、q 为不同节点且均存在于给定的二叉搜索树中。



~~~go
/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val   int
 *     Left  *TreeNode
 *     Right *TreeNode
 * }
 */

func lowestCommonAncestor(root, p, q *TreeNode) *TreeNode {
	for root!=nil{
        if p.Val<root.Val && q.Val<root.Val{
            root = root.Left
        } else if p.Val > root.Val && q.Val > root.Val{
            root =root.Right
        } else {
            return root
        }
    }
    return root
}
~~~



### 第九天

#### 733.图像渲染

有一幅以 m x n 的二维整数数组表示的图画 image ，其中 image[i][j] 表示该图画的像素值大小。

你也被给予三个整数 sr ,  sc 和 newColor 。你应该从像素 image[sr][sc] 开始对图像进行 上色填充 。

为了完成 上色工作 ，从初始像素开始，记录初始坐标的 上下左右四个方向上 像素值与初始坐标相同的相连像素点，接着再记录这四个方向上符合条件的像素点与他们对应 四个方向上 像素值与初始坐标相同的相连像素点，……，重复该过程。将所有有记录的像素点的颜色值改为 newColor 。

最后返回 经过上色渲染后的图像 。

 

示例 1:



输入: image = [[1,1,1],[1,1,0],[1,0,1]]，sr = 1, sc = 1, newColor = 2
输出: [[2,2,2],[2,2,0],[2,0,1]]
解析: 在图像的正中间，(坐标(sr,sc)=(1,1)),在路径上所有符合条件的像素点的颜色都被更改成2。
注意，右下角的像素没有更改为2，因为它不是在上下左右四个方向上与初始点相连的像素点。
示例 2:

输入: image = [[0,0,0],[0,0,0]], sr = 0, sc = 0, newColor = 2
输出: [[2,2,2],[2,2,2]]


提示:

m == image.length
n == image[i].length
1 <= m, n <= 50
0 <= image[i][j], newColor < 216
0 <= sr < m
0 <= sc < n

~~~go
var (
    dx = []int{-1,1,0,0}
    dy = []int{0,0,-1,1}
)
func floodFill(image [][]int, sr int, sc int, color int) [][]int {
    currcolor:=image[sr][sc]
    if currcolor != color {
        dfs(image,sr,sc,currcolor,color)
    }
    return image
}
func dfs(image [][]int,x,y,currcolor,color int){
    if image[x][y]==currcolor{
        image[x][y]=color
        for i:=0;i<4;i++{
            tx,ty:=x+dx[i],y+dy[i]
            if tx>=0&&tx<len(image)&&ty>=0&&ty<len(image[0]) {
                dfs(image,tx,ty,currcolor,color)
            }
        }
    }
}
~~~



### 第十天

#### 509.斐波那契数列

斐波那契数 （通常用 F(n) 表示）形成的序列称为 斐波那契数列 。该数列由 0 和 1 开始，后面的每一项数字都是前面两项数字的和。也就是：

F(0) = 0，F(1) = 1
F(n) = F(n - 1) + F(n - 2)，其中 n > 1
给定 n ，请计算 F(n) 。

 

示例 1：

输入：n = 2
输出：1
解释：F(2) = F(1) + F(0) = 1 + 0 = 1
示例 2：

输入：n = 3
输出：2
解释：F(3) = F(2) + F(1) = 1 + 1 = 2
示例 3：

输入：n = 4
输出：3
解释：F(4) = F(3) + F(2) = 2 + 1 = 3


提示：

0 <= n <= 30

~~~go
func fib(n int) int {
    if n < 2 {
        return n
    } 
    f1,f2,f3:=0,1,1
    for i:=2;i<n;i++ {
        f1=f2
        f2=f3
        f3=f1+f2
    }
    return f3
}
~~~



#### 70.爬楼梯

假设你正在爬楼梯。需要 n 阶你才能到达楼顶。

每次你可以爬 1 或 2 个台阶。你有多少种不同的方法可以爬到楼顶呢？

 

示例 1：

输入：n = 2
输出：2
解释：有两种方法可以爬到楼顶。

1. 1 阶 + 1 阶
2. 2 阶
   示例 2：

输入：n = 3
输出：3
解释：有三种方法可以爬到楼顶。

1. 1 阶 + 1 阶 + 1 阶
2. 1 阶 + 2 阶
3. 2 阶 + 1 阶


提示：

1 <= n <= 45

~~~go
func climbStairs(n int) int {
    if n < 2 {
        return n
    } 
    f1,f2,f3:=0,1,2
    for i:=2;i<n;i++ {
        f1=f2
        f2=f3
        f3=f1+f2
    }
    return f3
}
~~~



### 第十一天

给你一个整数数组 cost ，其中 cost[i] 是从楼梯第 i 个台阶向上爬需要支付的费用。一旦你支付此费用，即可选择向上爬一个或者两个台阶。

你可以选择从下标为 0 或下标为 1 的台阶开始爬楼梯。

请你计算并返回达到楼梯顶部的最低花费。

 

示例 1：

输入：cost = [10,15,20]
输出：15
解释：你将从下标为 1 的台阶开始。

- 支付 15 ，向上爬两个台阶，到达楼梯顶部。
  总花费为 15 。
  示例 2：

输入：cost = [1,100,1,1,1,100,1,1,100,1]
输出：6
解释：你将从下标为 0 的台阶开始。

- 支付 1 ，向上爬两个台阶，到达下标为 2 的台阶。
- 支付 1 ，向上爬两个台阶，到达下标为 4 的台阶。
- 支付 1 ，向上爬两个台阶，到达下标为 6 的台阶。
- 支付 1 ，向上爬一个台阶，到达下标为 7 的台阶。
- 支付 1 ，向上爬两个台阶，到达下标为 9 的台阶。
- 支付 1 ，向上爬一个台阶，到达楼梯顶部。
  总花费为 6 。


提示：

2 <= cost.length <= 1000
0 <= cost[i] <= 999

~~~go
/*
	动态规划
	方程为：
	f[i]=min(f[i-1]+cost[i-1],f[i-2]+cost[i-2])
*/
func minCostClimbingStairs(cost []int) int {
    cost_len:=len(cost)
    f:=make([]int , cost_len+1)
    f[0]=0
    f[1]=0
    for i:=2;i<=cost_len;i++ {
        f[i]=min(f[i-1]+cost[i-1],f[i-2]+cost[i-2])
    }
    return f[cost_len]
}
func min(a int,b int) int {
    if a>b {
        return b
    } else {
        return a
    }
}
~~~



#### 62.不同路径

一个机器人位于一个 m x n 网格的左上角 （起始点在下图中标记为 “Start” ）。

机器人每次只能向下或者向右移动一步。机器人试图达到网格的右下角（在下图中标记为 “Finish” ）。

问总共有多少条不同的路径？

 

示例 1：


输入：m = 3, n = 7
输出：28
示例 2：

输入：m = 3, n = 2
输出：3
解释：
从左上角开始，总共有 3 条路径可以到达右下角。

1. 向右 -> 向下 -> 向下
2. 向下 -> 向下 -> 向右
3. 向下 -> 向右 -> 向下
   示例 3：

输入：m = 7, n = 3
输出：28
示例 4：

输入：m = 3, n = 3
输出：6


提示：

1 <= m, n <= 100
题目数据保证答案小于等于 2 * 109

![题干图示例](https://assets.leetcode.com/uploads/2018/10/22/robot_maze.png)

~~~go
/*
执行用时：
0 ms, 在所有 Go 提交中击败了100.00%的用户
内存消耗：
1.9 MB, 在所有 Go 提交中击败了56.14%的用户
通过测试用例：
63 / 63
2022/12/21 20：11

动态规划
方程为：dp[i][j]=dp[i-1][j]+dp[i][j-1]
*/
func uniquePaths(m int, n int) int {
     dp := make([][]int, m)
    for i := range dp {
        dp[i] = make([]int, n)
        dp[i][0] = 1
    }
    for i:=0;i<n;i++ {
        dp[0][i]=1
    }
    for i:=1;i<m;i++ {
        for j:=1;j<n;j++ {
            dp[i][j]=dp[i-1][j]+dp[i][j-1]
        }
    }
    return dp[m-1][n-1]
}
~~~

