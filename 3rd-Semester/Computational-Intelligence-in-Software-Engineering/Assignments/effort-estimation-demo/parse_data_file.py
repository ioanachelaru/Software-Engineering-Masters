from csv import reader


if __name__ == '__main__':

    # open file in read mode
    with open('data.csv', 'r') as read_obj:
        # pass the file object to reader() to get the reader object
        csv_reader = reader(read_obj)
        # Iterate over each row in the csv using reader object
        for row in csv_reader:
            # row variable is a list that represents a row in csv
            file = row[0]
            included_files = row[1].split(" ")

            with open('graph.txt', 'a') as out_file:
                for j in included_files:
                    out_file.write(file + ' ' + j + '\n')
