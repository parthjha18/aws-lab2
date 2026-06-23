Installation of Maven on Linux

Install Java

1. Update packages
   sudo yum update -y

2. Install Java 17 (Amazon Corretto)
   sudo yum install java-17-amazon-corretto -y

3. Verify Java installation
   java -version

Install Maven

4. Install Java 8 (Amazon Corretto)
   sudo dnf install -y java-1.8.0-amazon-corretto

5. Install Maven
   sudo yum install maven -y

6. Verify Maven installation
   mvn -version

Generate Maven Project

mvn archetype:generate

Choose the following options when prompted:

1. Choose a number or apply filter:
   2309

2. Choose analysis-engine-archetype version:
   3

3. Define value for property 'analysisEngineClassName':
   analysis

4. Define value for property 'groupId':
   group1

5. Define value for property 'artifactId':
   artifact1

6. Define value for property 'version' (1.0-SNAPSHOT):
   snapshot1

7. Define value for property 'package' (group1):
   package1

8. Confirm properties configuration:

analysisEngineClassName: analysis
groupId: group1
artifactId: artifact1
version: snapshot1
package: package1

9. Confirm:
   y

Verify Project Structure

ls

cd artifact1

ls

cat pom.xml

Build the Project

mvn clean install package

Verify Build Output

ls

cd target

ls
