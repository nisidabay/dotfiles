# How to Use the `tr` Command 

Syntax

The syntax for the tr command is as follows:

tr OPTION... SET1 [SET2]

The tr command accepts two sets of characters, usually with the same length, and
replaces the characters of the first set with the corresponding characters from
the second set.

A SET is basically a string of characters, including special backslash-escaped
characters.
Examples
Basic Character Replacement

In this example, the tr command will replace all characters from the standard
input ("linuxize") by mapping the characters from the first set with the
matching ones from the second set.

echo 'linuxize' | tr 'lin' 'red'

Output:

reduxeze

Each occurrence of l is replaced with r, i with e, and n with d.
Character Ranges

Character sets can also be defined using character ranges. Instead of writing:

echo 'linuxize' | tr 'lmno' 'wxyz'

You can use:

echo 'linuxize' | tr 'l-n' 'w-z'

Complement Option

When the -c or --complement option is used, tr replaces all characters that are
not in SET1. In the following example, all characters except "li" will be
replaced with the last character from the second set:

echo 'linuxize' | tr -c 'li' 'xy'

Output:

liyyyiyyy

Note that the output has one more visible character than the input. This is
because the echo command prints an invisible newline character \n, which is also
replaced with y. To echo a string without a newline, use the -n option with
echo.
Deleting Characters

The -d or --delete option tells tr to delete characters specified in SET1. When
deleting characters without squeezing, specify only one set. In the following
example, the command will remove l, i, and z characters:

echo 'Linuxize' | tr -d 'liz'

Output:

Lnuxe

The L character is not deleted because the input includes an uppercase L, while
the l character in the SET is lowercase.
Squeezing Repeated Occurrences

The -s or --squeeze-repeats option replaces a sequence of repeated occurrences
with the character set in the last SET. In the following example, tr removes the
repeated space characters:

echo "GNU     \    Linux" | tr -s ' '

Output:

GNU \ Linux

When SET2 is used, the sequence of the character specified in SET1 is replaced
with SET2.

echo "GNU     \    Linux" | tr -s ' ' '_'

Output:

GNU_\_Linux

Truncating SET1

The -t or --truncate-set1 option forces tr to truncate SET1 to the length of
SET2 before further processing. By default, if SET1 is larger than SET2, tr will
reuse the last character of SET2. Here is an example:

echo 'Linux ize' | tr 'abcde' '12'

Output:

Linux iz2

Now, use the same command with the -t option:

echo 'Linux ize' | tr -t 'abcde' '12'

Output:

Linux ize

You can see that the last three characters of SET1 are removed. SET1 becomes
"ab," the same length as SET2, and no replacement is made.
Combining Options

The tr command allows you to combine its options. For example, the following
command first replaces all characters except i with 0 and then squeezes the
repeated 0 characters:

echo 'Linux ize' | tr -cs 'i' '0'

Output:

0i0i0

The `tr` command is a useful utility in Linux for translating or deleting
characters. It is often used for simple text manipulation tasks. Here's a table
outlining some common options, along with examples and their corresponding
outputs:

| Option | Description                  | Example                                             | Output          |
| :----: | ---------------------------- | :-------------------------------------------------- | --------------- |
|  `-d`  | Delete characters specified  | `echo "Hello, World!" | tr -d 'o'`                  | `Hell, Wrld!`   |
|  `-s`  | Squeeze repeating characters | `echo "Hello     World!" | tr -s ' '`               | `Hello World!`  |
|  `-c`  | Complement set of characters | `echo "Hello, World!" | tr -c '[:alnum:]' '*'`      | `*************` |
|        | Translate characters         | `echo "Hello, World!" | tr '[:lower:]' '[:upper:]'` | `HELLO, WORLD!` |
|        | Convert to lowercase         | `echo "Hello, World!" | tr '[:upper:]' '[:lower:]'` | `hello, world!` |

Note: In the examples, the `echo` command is used to provide input to the `tr`
command. You can replace it with any command or input file as per your
requirement.



