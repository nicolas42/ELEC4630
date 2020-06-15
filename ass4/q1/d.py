import face_recognition
from PIL import Image, ImageDraw
import numpy as np

# Load 'passport photo'
passport_filename = "faces/image_0001.jpg"
passport_image = face_recognition.load_image_file(passport_filename)
passport_face_encoding = face_recognition.face_encodings(passport_image)[0]
passport_photos = [ passport_face_encoding ]

distances = []
for i in range(2,451): 

    # Take a photo at the airport
    unknown_filename = "faces/image_{:04d}.jpg".format(i)
    unknown_image = face_recognition.load_image_file(unknown_filename)
    face_locations = face_recognition.face_locations(unknown_image)
    face_encodings = face_recognition.face_encodings(unknown_image, face_locations)

    # Get most similar face and note down the similarity metric (distance)
    if len(face_encodings) == 0:
        distances.append(1)
        print(unknown_filename, 1)
    else:
        # get all the distances
        detection_distances = []
        for face_encoding in face_encodings:
            detection_distances.append(
                face_recognition.face_distance(passport_photos, face_encoding))
        # keep the closest one
        distances.append(min(detection_distances))
        print(unknown_filename, min(detection_distances))
    


