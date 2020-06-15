import numpy as np
import matplotlib.pyplot as plt
from itertools import cycle

from sklearn import svm, datasets
from sklearn.metrics import roc_curve, auc
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import label_binarize
from sklearn.multiclass import OneVsRestClassifier
from scipy import interp
from sklearn.metrics import roc_auc_score

# images 2-21 match image 1
# so if positive they would constitute a true positive result
# if we get a distance under the threshold it is a positive result

from distances import distances
# thresholds = [ 0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0 ]

tpr = []
fpr = []

for threshold in np.arange(0,1.0,0.001):
       tp = 0
       fp = 0
       fn = 0
       tn = 0
       for i, distance in enumerate(distances):
              image_number = i+2
              if distance < threshold: # positive
                     if image_number <= 21:
                            tp += 1
                     else:
                            fp += 1
              else: # negative
                     if image_number <= 21:
                            fn += 1
                     else:
                            tn += 1
       
       tpr.append( tp / ( tp + fn ) )
       fpr.append( fp / ( fp + tn ) )

print(tpr, fpr)
tpr = np.array(tpr)
fpr = np.array(fpr)



plt.figure()
lw = 2
plt.plot(fpr, tpr, color='darkorange', lw=lw, label='AUC = 1')
plt.plot([0, 1], [0, 1], color='navy', lw=lw, linestyle='--')
plt.xlim([0.0, 1.0])
plt.ylim([0.0, 1.05])
plt.xlabel('False Positive Rate')
plt.ylabel('True Positive Rate')
plt.title('Receiver operating characteristic example')
plt.legend(loc="lower right")
plt.show()

