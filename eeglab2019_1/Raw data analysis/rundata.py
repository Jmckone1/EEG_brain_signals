from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, Conv2D, Flatten, MaxPooling2D # , Dropout
from tensorflow.keras.preprocessing.image import ImageDataGenerator
import pickle
import numpy as np

x_data = pickle.load(open("C:/Users/Josh/Desktop/Data_run_outputs/cwt.pkl", "rb"))
y_data = pickle.load(open("C:/Users/Josh/Desktop/Data_run_outputs/class.pkl","rb"))

array = np.array(list(x_data.items()))

for val in range(len(array)):
    complex = np.array(array[val])[1]
    split = np.array([np.real(complex), np.imag(complex)]).transpose(1, 2, 0)
    out1 = np.square(split)
    out2 = out1[:,0] + out1[:,1]
    out3 = np.sqrt(out2)
    if val == 0:
        break

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
