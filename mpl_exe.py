#!/usr/bin/python

import os
import sys

def insert_line_at_top (file_name, line):
    """ Insert given string (line) as a new line at the beginning of file_name """
    dummy_file = file_name + '.bak'
    with open(file_name, 'r') as read_obj, open(dummy_file, 'w') as write_obj:
        write_obj.write(line + '\n')
        for line in read_obj:
            write_obj.write(line)
    os.remove(file_name)
    os.rename(dummy_file, file_name)
    
def remove_n_line_at_top(file_name, n):
    """ Remove the first n line of the file_name """
    dummy_file = file_name + '.bak'
    with open(file_name, 'r') as read_obj, open(dummy_file, 'w') as write_obj:
        data = read_obj.read().splitlines(True);
        write_obj.writelines(data[n:])
    os.remove(file_name)
    os.rename(dummy_file, file_name)

def run_maple_prec(file_name, prec):
    """ Run Maple file with precision = prec """ 
    insert_line_at_top(file_name, "prec := "+prec+":")
    os.system("maple "+file_name)
    remove_n_line_at_top(file_name, 1);

def main():
    if len(sys.argv) == 1 :
        print("missing file_name and precision")
        print("try mpl_exe.py -h")
    elif sys.argv[1] == '-h':
        print("argv[1] : file_name")
        print("argv[2] : prec (integer) or lowerbound of prec")
        print("argv[3] : upperbound of prec")
    elif len(sys.argv) == 3 :
        run_maple_prec(str(sys.argv[1]), sys.argv[2])
    elif len(sys.argv) == 4:
        for i in range(int(sys.argv[2]), int(sys.argv[3])+1):
            run_maple_prec(str(sys.argv[1]), i)            
                        
if __name__ == '__main__':
    main()