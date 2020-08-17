from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, Conv2D, Flatten, MaxPooling2D # , Dropout
from tensorflow.keras.preprocessing.image import ImageDataGenerator
import os
import matplotlib.pyplot as plt
import pickle
from sklearn.model_selection import train_test_split
import numpy as np

data_train_len = len(os.listdir('C:/Users/Josh/Desktop/Test_Train/a_cwt_amp_train'))
data_test_len = len(os.listdir('C:/Users/Josh/Desktop/Test_Train/a_cwt_amp_test'))
data_train_loc = 'C:/Users/Josh/Desktop/Test_Train/a_cwt_amp_train'
data_test_loc = 'C:/Users/Josh/Desktop/Test_Train/a_cwt_amp_test'

#labels1 = pickle.load(open("C:/Users/Josh/Desktop/Data_run_outputs/class.pkl","rb"))
#labels2 = list(labels1.items())
#labelsval = np.array(labels2)[500:,1]
#labelsVal = labelsval.tolist()
#l = list(map(round, labelsVal))
#l2 = list(map(str, l))

# set up parameters
batch_size = 128
epochs = 5
IMG_HEIGHT = 100
IMG_WIDTH = 100

#stft = 2049,53
#cwt = 45,2049
#fft = 2049,7

# create functions for image rescaling and class allocation
data_image_generator = ImageDataGenerator(validation_split=0.2)

train_data_data_gen = data_image_generator.flow_from_directory(
        batch_size=batch_size,
        directory=data_train_loc,
        shuffle=False,
        classes = ["0","1"],
        class_mode="binary",
        subset='training',
        interpolation="nearest",
        target_size=(IMG_HEIGHT, IMG_WIDTH),
        color_mode="rgb"
        )

val_data_data_gen = data_image_generator.flow_from_directory(
        batch_size=batch_size,
        directory=data_train_loc,
        shuffle=False,
        classes = ["0","1"],
        class_mode="binary",
        subset='validation',
        interpolation="nearest",
        target_size=(IMG_HEIGHT, IMG_WIDTH),
        color_mode="rgb"
        )

test_data_data_gen = data_image_generator.flow_from_directory(
        batch_size=batch_size,
        directory=data_test_loc,
        shuffle=False,
        classes = ["0","1"],
        class_mode="binary",
        interpolation="nearest",
        target_size=(IMG_HEIGHT, IMG_WIDTH),
        color_mode="rgb"
        )

# sequential CNN, 3 convolution layers, 3 maxpooling layers, sigmoid activation
model = Sequential([
    Conv2D(16, 3, padding='same', activation='relu',
           input_shape=(IMG_HEIGHT, IMG_WIDTH ,3)),
    MaxPooling2D(),
    Conv2D(32, 3, padding='same', activation='relu'),
    MaxPooling2D(),
    Conv2D(64, 3, padding='same', activation='relu'),
    MaxPooling2D(),
    Flatten(),
    Dense(512, activation='relu'),
    Dense(1, activation='sigmoid')
])
    
# compile the model with binary cross entropy
model.compile(optimizer='adam',
          loss='binary_crossentropy',
          metrics=['accuracy','TruePositives',
                   'FalsePositives','TrueNegatives',
                   'FalseNegatives','Precision'])

# summary of the model structure - output to console
model.summary()

# fits the model to the training dataset, 
# validated with the validation dataset
history = model.fit(
    train_data_data_gen,
    steps_per_epoch=train_data_data_gen.samples // batch_size,
    epochs=epochs,
    validation_data=val_data_data_gen,
    validation_steps=val_data_data_gen.samples // batch_size
)

# predicts the outcome values for the test datset
result = model.predict(
    test_data_data_gen,
    steps = test_data_data_gen.samples // batch_size
)

# evaluates the test dataset, 
# assigning the metrics to a result_eval variable
result_eval = model.evaluate(
        test_data_data_gen,
        steps = test_data_data_gen.samples // batch_size
)

# gets the accuracy of the validation and train set
acc = history.history['accuracy']
val_acc = history.history['val_accuracy']

# gets the loss of the validation and train set
loss = history.history['loss']
val_loss = history.history['val_loss']

# gets the total number of epochs for plotting
epochs_range = range(epochs)

# plots the accuracy and loss metrics over the temporal space
plt.figure(figsize=(8, 8))
plt.subplot(1, 2, 1)
plt.plot(epochs_range, acc, label='Training Accuracy')
plt.plot(epochs_range, val_acc, label='Validation Accuracy')
plt.legend(loc='lower right')
plt.title('Training and Validation Accuracy')

plt.subplot(1, 2, 2)
plt.plot(epochs_range, loss, label='Training Loss')
plt.plot(epochs_range, val_loss, label='Validation Loss')
plt.legend(loc='upper right')
plt.title('Training and Validation Loss')
plt.show()

# get the history 
tn = history.history['TrueNegatives'][1]
fp = history.history['FalsePositives'][1]
fn = history.history['FalseNegatives'][1]
tp = history.history['TruePositives'][1]

sensitivity = tp / (tp + fn)
specificity = tn / (tn + fp)
precision = tp / (tp + fp)
f1 = 2*tp / ((2*tp) + fp + fn)

print(sensitivity)
print(specificity)
print(precision)
print(f1)