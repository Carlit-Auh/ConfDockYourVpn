#++++++++++++++++++++++++++++++++++++++
# PostgreSQL Docker container
#++++++++++++++++++++++++++++++++++++++
#
# Official images:
#
#   postgres - official PostgreSQL
#              https://hub.docker.com/_/postgres/
#
#++++++++++++++++++++++++++++++++++++++

FROM postgres:9.5
# # Set the locale
# RUN locale-gen fr_FR.UTF-8  
# ENV LANG fr_FR.UTF-8  
# ENV LANGUAGE fr_FR:fr  
# ENV LC_ALL fr_FR.UTF-8
