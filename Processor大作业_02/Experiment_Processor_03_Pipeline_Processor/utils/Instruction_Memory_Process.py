'''
Author: TX-Leo
Mail: tx.leo.wz@gmail.com
Date: 2022-07-22 15:03:21
Version: v1
File: 
Brief: 
'''
with open('./string_matching_kmp_pipeline.txt','r') as f1:
    with open("./Instruction_Memory_Process.txt", "w") as f2:
        for i,line in enumerate(f1):
            i_1 = i % 16
            i_2 = int(i / 16)
            if i_1 > 9:
                if i_1 % 10 == 0:
                    i_1 = 'A'
                elif i_1 % 10 == 1:
                    i_1 = 'B'
                elif i_1 % 10 == 2:
                    i_1 = 'C'
                elif i_1 % 10 == 3:
                    i_1 = 'D'
                elif i_1 % 10 == 4:
                    i_1 = 'E'
                elif i_1 % 10 == 5:
                    i_1 = 'F'

            if i_2 > 9:
                if i_2 % 10 == 0:
                    i_2 = 'A' # attention!
                elif i_2 % 10 == 1:
                    i_2 = 'B'
                elif i_2 % 10 == 2:
                    i_2 = 'C'
                elif i_2 % 10 == 3:
                    i_2 = 'D'
                elif i_2 % 10 == 4:
                    i_2 = 'E'
                elif i_2 % 10 == 5:
                    i_2 = 'F'

            if i_2 == 0:
                string = "data[9'h"+str(i_1)+"]"+" <= 32'h"+str(line.strip())+";"
                print(string)
            else:
                string = "data[9'h"+str(i_2)+str(i_1)+"]"+" <= 32'h"+str(line.strip())+";"
                print(string)
            f2.write(string+"\n")

