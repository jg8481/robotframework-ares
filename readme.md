# Robotframework ARES

Example for using TestAstra/ARES in robotframework 
[![HitCount](http://hits.dwyl.io/adiralashiva8/robotframework-ares.svg)](http://hits.dwyl.io/adiralashiva8/robotframework-ares)

---

*What is ARES?*

  ARES is a web based portal, which provides automation results at one place (Centralized Reports, Historical Data and Live Execution).

  For more info, features, account creation refer - [ARES Introduction](https://github.com/testastra/ARES/blob/master/Tutorials/01_Introduction.md)

 - ARES Dashboard Website : https://testastra.com/ares
 
 - ARES Git (tutorial and sample usage) : https://github.com/testastra/ARES

---

HOW TO USE:

Prerequisites (Mandatory)
 
 - Knowledge on robotframework
 
 - Install Python requests to make REST API calls
   > `pip install requests`
 
 - Created project in ARES
   > Refer [01_Introduction.md](https://github.com/testastra/ARES/blob/master/Tutorials/01_Introduction.md)

Steps to Use:

 - Step 1: Download this repo
 
 - Step 2: Copy `AresListener.py`, `config.py` to your project
 
 - Step 3: Modify `config.py` with USER_TOKEN, PROJECT NAME/TOKEN etc., fields
   > - Create account in ARES,
   > - Create project and 
   > - Copy details which are explained in *01_Introduction.md*

 - Step 4: Execute test case/suites using areslistener
   > - `robot --listener AresListener.py -V config.py Tests/FirstSuite.robot` 

 - Step 5: Go to ares dashboard
   > You can find live execution, detailed report and charts

---

ARES Dashboard QUICK OVERVIEW

*LIVE EXECUTION*

  <a href="https://ibb.co/QkFJ8Xd"><img src="https://i.ibb.co/bFg6H7J/ARES-LIVE.jpg" alt="ARES-LIVE" border="0"></a>

*DASHBOARD*

   <a href="https://ibb.co/xD7YX41"><img src="https://i.ibb.co/f2x9qck/ARES-DASHBOARD.jpg" alt="ARES-DASHBOARD" border="0" /></a>

*HISTORIC DATA*

   <a href="https://ibb.co/q71TsM7"><img src="https://i.ibb.co/jb4nMvb/ARES-DETAILED.jpg" alt="ARES-DETAILED" border="0"></a>

---