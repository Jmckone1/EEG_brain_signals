from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, Conv2D, Flatten, MaxPooling2D # , Dropout
from tensorflow.keras.preprocessing.image import ImageDataGenerator
import pickle
import numpy as np
import matplotlib as plt
import matplotlib.image as mpimg
import matplotlib.pyplot as img

x_data = pickle.load(open("C:/Users/Josh/Desktop/Data_run_outputs/stft.pkl", "rb"))
#y_data = pickle.load(open("C:/Users/Josh/Desktop/Data_run_outputs/class.pkl","rb"))

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
#    img.imsave(saveloc + "a_cwt_amp/" + str(val) + "amp.png",out3)
#    img.imsave(saveloc + "a_cwt_pha/" + str(val) + "phase.png",out6)
#    img.imsave(saveloc + "a_fft_amp/" + str(val) + "amp.png",out3)
#    img.imsave(saveloc + "a_fft_pha/" + str(val) + "phase.png",out6)
    img.imsave(saveloc + "a_stft_amp/" + str(val) + "amp.png",out3)
    img.imsave(saveloc + "a_stft_pha/" + str(val) + "phase.png",out6)
#    if val == 0:
#        break

img.imshow(out3,aspect='auto')
#import matplotlib
#
#for val in range(array.shape[0]):
#    matplotlib.image.imsave(str(val) + '.png', array[val,1])

#output = np.array(array[1,1])
#for val in range(array.shape[0]):
#    print(val)
#    output = np.append(array[val,1],output)

#output = np.array(array[:,1])

#datagen = ImageDataGenerator(
#    featurewise_center=True,
#    featurewise_std_normalization=True,
#    rotation_range=20,
#    width_shift_range=0.2,
#    height_shift_range=0.2,
#    horizontal_flip=True)
#
#datagen.fit(array)
