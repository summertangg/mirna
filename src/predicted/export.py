import os
import psycopg2
import pandas as pd
from itertools import product
from db_helper import *
from config import mir17_training_set as m17
from config import mir10_testing_set as m10
from config import mir26_testing_set as m26
from config import mir54_training_set as m54
from config import mir_lawrie_testing_set as mlawrie
from config import mir_larrabeiti_testing_set as mlar
from config import mir_beheshti_testing_set as mbe
from config import mir_sun_testing_set as msun
from config import mir_bouvy_testing_set as mbou


def export_interactions(db_conn, root_path, out_file, config_mirna, config_seq):
    print("\n*** Exporting miRNA - Gene interactions from miRDB records ......")
    file_path = os.path.join(root_path, out_file)
    cur = conn.cursor()

    mirnas = get_all_mirans(db_conn, cur)
    mirnas_dict = {record[0]: record[1] for record in mirnas}

    results = get_interactions_with_pathways(db_conn, cur, config_mirna)

    cur.close()

    # Convert the query results to a DataFrame
    df = pd.DataFrame(results, columns=["mirna", "gene", "is_target"])

    # Pivot the DataFrame
    pivot_df = pd.pivot_table(df, values="is_target", index="mirna", columns="gene", fill_value=0)

    # Remove the mir-0 row
    pivot_df.drop('mir-0', inplace=True)
    pivot_df.drop('PLACEHOLDER', axis=1, inplace=True)

    # Replace float values 1.0 and 0.0 with strings 'Yes' and 'No', respectively
    pivot_df = pivot_df.replace({1.0: 'Yes', 0.0: 'No'})
    disease_col = []
    num_of_base_col = []
    ratio_a_col = []
    ratio_c_col = []
    ratio_g_col = []
    ratio_u_col = []
    mass_col = []
    h_bonds_col = []
    two_base_col = {}
    for motif in motif_generator(2):
        two_base_col[motif] = []
    
    three_base_col = {}
    for motif in motif_generator(3):
        three_base_col[motif] = []

    four_base_col = {}
    for motif in motif_generator(4):
        four_base_col[motif] = []

    for index, row in pivot_df.iterrows():
        print(f"{index}: disease {mirnas_dict[index]}")
        if mirnas_dict[index] == 'DLBCL':
            disease_col.append('Yes')
        else:
            disease_col.append('No')

        num_of_base_col.append(len(config_seq[index]))
        ratio_a_col.append(frequency_of_base(config_seq[index], 'A'))
        ratio_c_col.append(frequency_of_base(config_seq[index], 'C'))
        ratio_g_col.append(frequency_of_base(config_seq[index], 'G'))
        ratio_u_col.append(frequency_of_base(config_seq[index], 'U'))
        mass_col.append(mean_mass(config_seq[index]))
        h_bonds_col.append(h_bonds(config_seq[index]))
        for motif in two_base_col.keys():
            two_base_col[motif].append('Yes' if motif in config_seq[index] else 'No')
        for motif in three_base_col.keys():
            three_base_col[motif].append('Yes' if motif in config_seq[index] else 'No')
        for motif in four_base_col.keys():
            four_base_col[motif].append('Yes' if motif in config_seq[index] else 'No')
    
    # insert to position: pivot_df.insert(0, 'DIAGNOSTIC_POSITIVE', disease_col)
    pivot_df['NUM_OF_BASES'] = num_of_base_col
    pivot_df['RATIO_A'] = ratio_a_col
    pivot_df['RATIO_C'] = ratio_c_col
    pivot_df['RATIO_G'] = ratio_g_col
    pivot_df['RATIO_U'] = ratio_u_col
    pivot_df['MEAN_MASS'] = mass_col
    pivot_df['H_BONDS'] = h_bonds_col
    for k, v in two_base_col.items():
        pivot_df[k] = v
    for k, v in three_base_col.items():
        pivot_df[k] = v
    for k, v in four_base_col.items():
        pivot_df[k] = v
    pivot_df['DIAGNOSTIC_POSITIVE'] = disease_col

    # Write the pivoted DataFrame to a CSV file
    pivot_df.to_csv(file_path, index=True)

    # Print a message
    print(f"{file_path} file saved successfully.")

def num_of_bases(seq):
    count_A = 0
    count_C = 0
    count_G = 0
    count_U = 0

    # Iterate through the sequence
    for v in seq:
        if v == 'A':
            count_A += 1
        elif v == 'C':
            count_C += 1
        elif v == 'G':
            count_G += 1
        elif v == 'U':
            count_U += 1
    
    base_count = {
        "A": count_A,
        "C": count_C,
        "G": count_G,
        "U": count_U
    }

    return base_count

def frequency_of_base(seq, base):
    total_base = len(seq)
    base_count = num_of_bases(seq)
    ratio = base_count[base]/total_base
    return "{:.2f}".format(ratio)

def mean_mass(seq):
    # 135.1 (NA)+111.1 (NC)+151.1 (NG)+112.1 (NU)/N
    total_base = len(seq)
    base_count = num_of_bases(seq)
    mass = (135.1 * base_count['A'] + 111.1 * base_count['C'] + 151.1 * base_count['G'] + 112.1 * base_count['U']) / total_base
    return "{:.2f}".format(mass)

def h_bonds(seq):
    # 2 (NA + NU)+3 (NC+ NG)
    total_base = len(seq)
    base_count = num_of_bases(seq)
    bonds = 2 * (base_count['A'] + base_count['U']) + 3 * (base_count['C'] + base_count['G'])
    return bonds

def motif_generator(num):
    bases = ['A', 'C', 'G', 'U']
    motifs = [''.join(p) for p in product(bases, repeat=num)]
    return motifs

root_path = "~/code/mirna/resources/results"
conn = psycopg2.connect(database="postgres", user="postgres", password="1qaz2wsX", host="127.0.0.1", port="5432")
try:
    export_interactions(conn, root_path, m54.interaction_file, m54.all_mirnas, m54.sequence_all)

    export_interactions(conn, root_path, mlawrie.table_1_file, mlawrie.table_1, mlawrie.sequence_table_1)
    export_interactions(conn, root_path, mlawrie.table_1_file_clean, mlawrie.table_1_clean, mlawrie.sequence_table_1)

    export_interactions(conn, root_path, mlawrie.table_2_file, mlawrie.table_2, mlawrie.sequence_table_2)
    export_interactions(conn, root_path, mlawrie.table_2_file_clean, mlawrie.table_2_clean, mlawrie.sequence_table_2)

    export_interactions(conn, root_path, mlar.table_1_file, mlar.table_1, mlar.sequence_table_1)
    export_interactions(conn, root_path, mlar.table_1_file_clean, mlar.table_1_clean, mlar.sequence_table_1)


    export_interactions(conn, root_path, mbe.fig_1_file, mbe.fig_1, mbe.sequence_fig_1)
    export_interactions(conn, root_path, mbe.fig_1_file_clean, mbe.fig_1_clean, mbe.sequence_fig_1)

    export_interactions(conn, root_path, msun.fig_1_file, msun.fig_1, msun.sequence_fig_1)
    export_interactions(conn, root_path, msun.fig_1_file_clean, msun.fig_1_clean, msun.sequence_fig_1)

    export_interactions(conn, root_path, mbou.table_2_file, mbou.table_2, mbou.sequence_table_2)
    export_interactions(conn, root_path, mbou.table_2_file_clean, mbou.table_2_clean, mbou.sequence_table_2)

except(Exception, psycopg2.DatabaseError) as error:
    raise error
finally:
    conn.close()
