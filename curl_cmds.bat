rem set the working dir to the NLC_train folder
cd %~dp0
cd NLC_train

rem to create and train the classifier based on a train.csv file
curl -u "{username}":"{password}" -F training_data=@train.csv -F training_metadata="{\"language\":\"en\",\"name\":\"My Classifier\"}" "https://gateway.watsonplatform.net/natural-language-classifier/api/v1/classifiers"


rem to check the status of a classifier
curl -u "{username}":"{password}" "https://gateway.watsonplatform.net/natural-language-classifier/api/v1/classifiers/{classifier_id}"