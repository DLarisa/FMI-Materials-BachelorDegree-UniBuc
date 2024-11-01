XML files in xmlmetadata directory describe properties and structure of objects that can be created with Oracle SQL Developer Data Modeler UI or using scripting. They are used by Data Modeler (DM) in its functionality thus any changes introduced to them could break normal functionality of DM.
XML files follow internal object model used by DM and all properties of specific object can be found following parent class link. There is an HTML presentation of XML files in doc directory (use index.html) which allow faster navigation in class hierarchy – direct descendents of each class are also presented there. 
Two important groups can be found in each XML file – properties and collections. They can be marked as external which means that property or collection is stored outside the file that represents the object. As example – Table has internal collection “columns” i.e. columns are stored in the file that represents table; RelationalDesign class (representing relational model) has external collection Tables. Design class (representing the whole design) has external property LogicalModel and external collection RelationalModels.
Each property has getter and setter method defined that can be used to get property or set it using scripting. Collection definition provide createItem method that can be used to create item of that collection using instance of surrounding object – back to Tables collection we see that table can be created using model.createTable().
ModelObject is the root of the hierarchy and each model is also instance of DesignPart class.
Changed object should be marked as changed using setDirty(true) method otherwise they won’t be saved during save operation.
Each collection with type xxxxxSet allows objects to be found by name ( method getByName(name) ) and by object ID (method getObjectByID(objectID) ). Collections for tables and views in relational model also allows object to be found by schema and name using method getBySchemaAndName(schema, name). Method iterator() can be used to iterate over objects or toArray() to get them in array. 
Each object has unique ID  (method getObjectID() ) that can be used to get the object using method of Design instance  – in scripting it’ll be model.getDesign().getDesignObject( ID )  - that doesn’t cover objects in physical models. Objects in relational and data types models have counterpart in physical model that has the same ID and can be found through instance of physical model (StorageDesign class) – for relational model – model.getStorageDesign().getStorageObject( ID ).
Though DM store design in set of directories and files, one can use scripting to store the whole design (or one model) into single file and to restore the status from such file:
- Saving:
model.getAppView().getXMLTransformationManager().saveObjectWithExternals("D:/SVN_Local_files/handy_whole_des_big.xml",model.getDesign());
- Loading
Since design will take the status as it’s stored in the file it’s good to be sure design is empty – method isEmpty() can be used for models (DesignPart class).
model.getAppView().getXMLTransformationManager().loadObjectWithExternals("D:/SVN_Local_files/handy_whole_des_big.xml",model.getDesign());
Note about physical models – only Oracle physical models are described in current revision of XML metadata thus non Oracle physical models cannot be saved into single file.
Difference between transformation and design rule – design rule is invoked for each object it’s set to while transformation is invoked only once.


