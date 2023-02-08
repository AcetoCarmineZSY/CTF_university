echo "#include <stdlib.h>" > /home/test/exec.c
echo "#include <stdio.h>" >> /home/test/exec.c
echo "#include <unistd.h>" >> /home/test/exec.c
echo "#include <string.h>" >> /home/test/exec.c
echo " " >> /home/test/exec.c
echo "int main(int argc, char *argv[]){" >> /home/test/exec.c
echo " " >> /home/test/exec.c
echo " printf("%s,%dn", "USER ID:",getuid());" >> /home/test/exec.c
echo " printf("%s,%dn", "EXEC ID:",geteuid());" >> /home/test/exec.c
echo " " >> /home/test/exec.c
echo " printf("Enter OS command:");" >> /home/test/exec.c
echo " char line[100];" >> /home/test/exec.c
echo " fgets(line,sizeof(line),stdin);" >> /home/test/exec.c
echo " line[strlen(line) - 1] = ''; " >> /home/test/exec.c
echo " char * s = line;" >> /home/test/exec.c
echo " char * command[5];" >> /home/test/exec.c
echo " int i = 0;" >> /home/test/exec.c
echo " while(s){" >> /home/test/exec.c
echo " command[i] = strsep(&s," ");" >> /home/test/exec.c
echo " i++;" >> /home/test/exec.c
echo " }" >> /home/test/exec.c
echo " command[i] = NULL;" >> /home/test/exec.c
echo " execvp(command[0],command);" >> /home/test/exec.c
echo "}" >> /home/test/exec.c

gcc -o /home/test/exec exec.c
rm exec.c
chmod 4755 exec