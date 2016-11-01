#######################################################
#################     DESCRIPTION    ##################
#######################################################
#                                                     #
#        Run This Code to Start The Application       #
#                                                     #
#######################################################


from ProjectApp import app                     # app being defined in __init__.py in ProjectApp directory

app.run(host='localhost',port=3000,debug=True) # running aplication on specified host and port