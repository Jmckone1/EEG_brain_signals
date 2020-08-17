#stft = 2049,53
#cwt = 45,2049
#fft = 2049,7


import pickle
import numpy as np
import matplotlib.pyplot as img

x_data = pickle.load(open("C:/Users/Josh/Desktop/Data_run_outputs/fft.pkl", "rb"))

data_loc = 'C:/Users/Josh/Desktop/Data_run_outputs'
labels1 = pickle.load(open("C:/Users/Josh/Desktop/Data_run_outputs/class.pkl","rb"))
labels2 = list(labels1.items())
labelsval = np.array(labels2)[:,1].T
labelsVal = labelsval.tolist()
l = list(map(round, labelsVal))

saveloc = "C:/Users/Josh/Desktop/Data_run_outputs/"

array = np.array(list(x_data.items()))

## this is the amplitude calcuation for each of the things
#for val in range(len(array)):
#    complex = np.array(array[val])[1]
#    split = np.array([np.real(complex), np.imag(complex)]).transpose(1, 2, 0)
#    out1 = np.square(split)
#    out2 = np.add(out1[:,:,0],out1[:,:,1])
#    out3 = np.sqrt(out2)
#    if val == 0:
#        break

# this is the amplitude calcuation for each of the things
for val in range(len(array)):
    print(str(val+1) + " / " + str(len(array)))
    complex1 = np.array(array[val])[1]
    split = np.array([np.real(complex1), np.imag(complex1)]).transpose(1, 2, 0)
    out1 = np.square(split)
    out2 = np.add(out1[:,:,0],out1[:,:,1])
    # out3 is synonymous with the amplitude calculation
    out3 = np.sqrt(out2)
    out4 = np.add(out3,out1[:,:,0])
    out5 = np.divide(out1[:,:,1],out4)
    # out6 makes up the phase calculation
    out6 = np.multiply(2,np.arctan(out5))
#    if l[val] == 0:
##        img.imsave(saveloc + "a_cwt_amp/0/" + str(val) + "amp.png",out3)
##        img.imsave(saveloc + "a_cwt_pha/0/" + str(val) + "phase.png",out6)
##        img.imsave(saveloc + "a_fft_amp/0/" + str(val) + "amp.png",out3)
##        img.imsave(saveloc + "a_fft_pha/0/" + str(val) + "phase.png",out6)
#        img.imsave(saveloc + "a_stft_amp/0/" + str(val) + "amp.png",out3)
#        img.imsave(saveloc + "a_stft_pha/0/" + str(val) + "phase.png",out6)
#    if l[val] == 1:
##        img.imsave(saveloc + "a_cwt_amp/1/" + str(val) + "amp.png",out3)
##        img.imsave(saveloc + "a_cwt_pha/1/" + str(val) + "phase.png",out6)
##        img.imsave(saveloc + "a_fft_amp/1/" + str(val) + "amp.png",out3)
##        img.imsave(saveloc + "a_fft_pha/1/" + str(val) + "phase.png",out6)
#        img.imsave(saveloc + "a_stft_amp/1/" + str(val) + "amp.png",out3)
#        img.imsave(saveloc + "a_stft_pha/1/" + str(val) + "phase.png",out6)
    if val == 0:
        break

img.imshow(out3,aspect='auto')