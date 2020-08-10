import os, os.path
from scipy.io import loadmat
import pickle

cwt_data = loadmat('C:/Users/Josh/Desktop/Data_run_outputs/dataset_02/cwt/time_1.mat')
print(cwt_data['cwt'].shape)
# https://towardsdatascience.com/how-to-load-matlab-mat-files-in-python-1f200e1287b5

fft_data = loadmat('C:/Users/Josh/Desktop/Data_run_outputs/dataset_02/fft/time_1.mat')
print(fft_data['fft_raw'].shape)

stft_data = loadmat(
        'C:/Users/Josh/Desktop/Data_run_outputs/dataset_02/stft/time_1.mat')

raw_stats = loadmat(
        'C:/Users/Josh/Desktop/Data_run_outputs/dataset_02/raw_stats.mat')
info = loadmat('C:/Users/Josh/Desktop/Data_run_outputs/dataset_02/info.mat')
print(raw_stats['stftStats'].shape)
print(info['info_matrix'][:,6].shape)

vcwt_data = {}
vstft_data = {}
vfft_data = {}

dataset_val = ["01","02","03","04","05","06","07",
               "08","09","10","11","12","13","14",
               "15","16","17","18","19","20","21",
               "22","23","24","25"]
start = 0

for val_x in range(len(dataset_val)):
    # path joining version for other paths
    DIR = 'C:/Users/Josh/Desktop/Data_run_outputs/dataset_' + str(dataset_val[val_x]) + '/cwt/'
    # print(len([name for name in os.listdir(DIR) if os.path.isfile(os.path.join(DIR, name))]))
    print("cwt")
    v = len([name for name in os.listdir(DIR) if os.path.isfile(os.path.join(DIR, name))])
    for loop_x in range(v):
        start += 1
        cwt_data = loadmat(DIR + 'time_' + str(v)+'.mat')
        vcwt_data[start] = cwt_data['cwt']
        
for val_x in range(len(dataset_val)):
    # path joining version for other paths
    DIR = 'C:/Users/Josh/Desktop/Data_run_outputs/dataset_' + str(dataset_val[val_x]) + '/stft/'
    # print(len([name for name in os.listdir(DIR) if os.path.isfile(os.path.join(DIR, name))]))
    print("stft")
    v = len([name for name in os.listdir(DIR) if os.path.isfile(os.path.join(DIR, name))])
    for loop_x in range(v):
        start += 1
        stft_data = loadmat(DIR + 'time_' + str(v)+'.mat')
        vstft_data[start] = stft_data['stft_raw']
        
for val_x in range(len(dataset_val)):
    # path joining version for other paths
    DIR = 'C:/Users/Josh/Desktop/Data_run_outputs/dataset_' + str(dataset_val[val_x]) + '/fft/'
    # print(len([name for name in os.listdir(DIR) if os.path.isfile(os.path.join(DIR, name))]))
    print("fft")
    v = len([name for name in os.listdir(DIR) if os.path.isfile(os.path.join(DIR, name))])
    for loop_x in range(v):
        start += 1
        fft_data = loadmat(DIR + 'time_' + str(v)+'.mat')
        vfft_data[start] = fft_data['fft_raw']

start = 0
vclass_data = {}
for val_x in range(len(dataset_val)):
    # path joining version for other paths
    DIR = 'C:/Users/Josh/Desktop/Data_run_outputs/dataset_' + str(dataset_val[val_x]) + '/'
    # print(len([name for name in os.listdir(DIR) if os.path.isfile(os.path.join(DIR, name))]))
    class_data = loadmat(DIR + 'info.mat')
    v = len(class_data['info_matrix'])
    for loop_x in range(v):
        start += 1
        vclass_data[start] = class_data['info_matrix'][loop_x,6]
        
a_file = open("cwt.pkl","wb")
pickle.dump(vcwt_data,a_file)
a_file.close()

b_file = open("stft.pkl","wb")
pickle.dump(vstft_data,b_file)
b_file.close()

c_file = open("fft.pkl","wb")
pickle.dump(vfft_data,c_file)
c_file.close()

d_file = open("class.pkl","wb")
pickle.dump(vclass_data,d_file)
d_file.close()

# data = pickle.load(open("save.pkl", "rb"))