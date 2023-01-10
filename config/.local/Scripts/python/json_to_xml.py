import json
import xml.etree.ElementTree as ET

#data = {
#  "Name": "JSON",
#  "Course": "Btech",
#  "Branch": "CSE",
#  "Result": [
#        {"Subject": "Python", "Score": 86},
#        {"Subject": "Java", "Score": 78},
#        {"Subject": "C", "Score": 95},
#        {"Subject": "C++", "Score": 90},
#      ]
#}


#root = ET.Element("contrevenant")
#ET.SubElement(root, "Name").text = data["Name"]
#ET.SubElement(root, "Course").text = data["Course"]
#ET.SubElement(root, "Branch").text = data["Branch"]
#result = ET.SubElement(root, "Result")

#for i in data["Result"]:
#    result = ET.SubElement(root,"Result")
#    ET.SubElement(result, "Subject").text = i["Subject"]
#    ET.SubElement(result, "Score").text = str(i["Score"])

#tree = ET.ElementTree(root)
#tree.write("student.xml")


data = {
  "contrevenants": {
        "contrevenant": [
            {"Subject": "Python", "Score": 86},
            {"Subject": "Java", "Score": 78},
            {"Subject": "C", "Score": 95},
            {"Subject": "C++", "Score": 90}
        ]
    }
}


root = ET.Element("contrevenants")

for i in data["contrevenants"]["contrevenant"]:
    result = ET.SubElement(root,"contrevenant")
    ET.SubElement(result, "Subject").text = i["Subject"]
    ET.SubElement(result, "Score").text = str(i["Score"])

tree = ET.ElementTree(root)
tree.write("student.xml")
