:q[BASH Programming](https://linuxhint.com/category/bash-programming/)

# How to Replace Everything after Pattern using `sed` Command

12 months ago

by [Fahmida Yesmin](https://linuxhint.com/author/fahmida_yesmin/)

Replacement tasks can be done in Linux in different ways. `sed` command is one of the ways to do replacement task. This command can be used to replace text in a string or a file by using a different pattern. How you can replace everything after the matching pattern using the `sed` command is shown in this tutorial.

## Replace everything after the match in a string:

How the part of a string can be replaced based on a matching pattern and $PARTITION_COLUMN has been shown in this section of this tutorial. But this variable works if the pattern matches any word in the beginning or middle of the string. It will not replace the text if the pattern matches with the last word of the string.

## Example-1: Replace all after the match using $PARTITION_COLUMN

The following command will search the character ‘a’, and the remaining part after ‘a’ will be replaced by the text, “a popular blog site”. $PARTITION_COLUMN.* is used to define the remaining part after the character, ‘a’.

*$* echo "LinuxHint is a website" | sed "s/a $PARTITION_COLUMN.*/a popular blog site/"

The following output will appear after running the command. Here, ‘a website’ has been replaced by ‘a popular blog site’.

![img](https://linuxhint.com/wp-content/uploads/2020/11/image4-8.jpg)
The following pattern will search the word ‘**web**’  in the string and replace the remaining part with the ‘**web**‘ by the text, ‘**a popular blog site**‘ if the match exists and ‘**web**‘ is not the part of the last word of the string.

*$* echo "LinuxHint is a website" | sed "s/web.* $PARTITION_COLUMN.*/a popular blog site/"

The following output will appear after running the command. Here, ‘website’ is the last word of the string, and no replacement has been done for this reason.

![img](https://linuxhint.com/wp-content/uploads/2020/11/image5-7.jpg)

## Example-2: Replace all after match using pattern

The following command will search the word ‘**bash**‘ globally in the string and replace everything with the word if the word exists in the string. ‘**g**‘ is used here for global search.

*$* echo "I like bash programming" | sed "s/bash.*/python script/g"

The following output will appear after running the command. Here, ‘bash’ exists in the middle of the string, and the replacement has been done.

![img](https://linuxhint.com/wp-content/uploads/2020/11/image7-5.jpg)

## Replace everything after the match in a file:

All content of a particular line or multiple lines or remaining lines of a file after the match can be replaced using the `**sed**` command. Create a text file named **attendance.txt** with the following content to test the examples shown in this section.

**attendance.txt**

1108885 is present

1999979 is present

1769994 is absent

1105656 is absent

1455999 is absent

## Example -3: Replace all content from a line of a file after the match

The following `sed` command will search the number 1769994 in the file, and everything with the number will be replaced by the text, ‘1586844 is present’ if the number exists in any line of the file.

$ cat allendence.txt

$ sed "s/1769994.*/1586844 is present/" attendance.txt

The following output will appear running the commands. Here, the searching number exists in the third line of the file, and the replacement has been done.

![img](https://linuxhint.com/wp-content/uploads/2020/11/image6-5.jpg)

## Example -4: Replace all content from the multiple lines of a file after the match

The following `sed` command shows the use of the $PARTITION_COLUMN variable to replace multiple lines from the file. The command will search ‘110’ at the starting of each line of the file and replace everything with ‘110’ by the text ‘Invalid Entry’ where the matching text will be found.

$ cat attendance.txt

$ sed "s/^110.* $PARTITION_COLUMN.*/Invalid Entry/" attendance.txt

The following output will appear after running the commands. ‘110’ exists in two lines of the file, and these have been replaced by the replacing text.
![img](https://linuxhint.com/wp-content/uploads/2020/11/image3-8.jpg)

## Example-5: Replace all content from a line of a file using ‘c’ after the match

The following `**sed**` command shows the use of ‘**c**‘ to replace everything after the match. Here, ‘**c**‘ indicates the change. The command will search the word ‘**present**‘ in the file and replace everything of the line with the text, ‘**This line is replaced**‘ if the word exists in any line of the file.

$ cat attendance.txt

$ sed '/present/c This line is replaced ' attendance.txt

The following output will appear after running the commands. The word ‘present’ exists in the first two lines of the file, and these two lines have been replaced by the replacing text.

![img](https://linuxhint.com/wp-content/uploads/2020/11/image1-11.jpg)

## Example-6: Replace all content from a line of a file based on starting and ending pattern

Sometimes it is required to replace text based on the starting and ending pattern. The following `sed` command shows the way to define starting and ending patterns to replace lines from a file. The command will search those lines in the file that starts with the number 110 and ends with the word ‘absent’ and replace everything with the word ‘replaced’ where the patterns match.

$ cat attendance.txt

$ sed -e 's/^110.*absent$/replaced/g' attendance.txt

The following output will appear after running the commands. Here, the first and the fourth lines start with the number 110, but the word ‘absent’ exists in the fourth line only. So, the fourth line of the file has been replaced by the replacing text.

![img](https://linuxhint.com/wp-content/uploads/2020/11/image2-10.jpg)