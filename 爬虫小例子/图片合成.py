from PIL import Image
import os

im = Image.open('./女神/一手托腮的美女刘亦菲 4.jpg')
w,h = im.size
print(w,h)
row = 4
high = 5

names = os.listdir('./女神')

new_img = Image.new('RGB', (high*w, row*h))
for x in range(row):
    for y in range(high):
        o_img = Image.open('./女神/'+names[high*x+y])
        new_img.paste(o_img, (y*w, x*h))
new_img.save('new_img.jpg')

