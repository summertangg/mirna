import os


def extract_attributes(root_path, in_file):
    file_path = os.path.join(root_path, in_file)
    file_path = os.path.abspath(os.path.expanduser(file_path))
    attributes = []
    with open(file_path, 'r') as file:
        for line in file:
            columns = line.strip().split()
            if len(columns) >= 3:
                attributes.append(columns[2])
    return attributes

def write_to_file(root_path, out_file, attributes):
    file_path = os.path.join(root_path, out_file)
    file_path = os.path.abspath(os.path.expanduser(file_path))
    with open(file_path, 'w') as file:
        for value in attributes:
            file.write(value + '\n')

root_path = "~/code/mirna/resources/results"
infogain_file = 'InfoGain_0.05.txt'
output_file_path = 'infogain_selected_attributes.txt'

attributes = extract_attributes(root_path, infogain_file)
write_to_file(root_path, output_file_path, attributes)
