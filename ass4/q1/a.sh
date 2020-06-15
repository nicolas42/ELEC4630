pip3 install dlib

# First store some sample images in the folder 'images'
mkdir -p images
cd images; wget -nc https://raw.githubusercontent.com/lovellbrian/ELEC4630/master/Images/obama.jpg
cd images; wget -nc https://raw.githubusercontent.com/lovellbrian/ELEC4630/master/Images/biden.jpg
cd images; wget -nc https://raw.githubusercontent.com/lovellbrian/ELEC4630/master/Images/two_people.jpg

pip3 install face_recognition
