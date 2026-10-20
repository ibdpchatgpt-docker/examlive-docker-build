
# ============================================================
# ExamLive - Dockerfile
# Java 11 + Apache Tomcat 9 + Spring MVC WAR
# ============================================================

# STEP 1: Use Tomcat 9 with Java 11
# This image already contains Java, Tomcat and Linux runtime.
FROM tomcat:9.0-jdk11-temurin

# STEP 2: Application information
LABEL app="ExamLive"
LABEL description="ExamLive Online Examination System"

# STEP 3: Set working directory
WORKDIR /usr/local/tomcat

# STEP 4: Remove Tomcat's default applications
RUN rm -rf /usr/local/tomcat/webapps/*

# STEP 5: Copy ExamLive WAR into Tomcat
# ROOT.war makes the application accessible at /
COPY ExamLive.war /usr/local/tomcat/webapps/ROOT.war

# STEP 6: Set JVM configuration
# Keep heap below the Kubernetes pod memory limit (3Gi).
ENV JAVA_OPTS="-Xms1g -Xmx2g -XX:+UseG1GC -XX:MaxGCPauseMillis=200"

# STEP 7: Document Tomcat application port
EXPOSE 8080

# STEP 8: Start Tomcat in foreground
CMD ["catalina.sh", "run"]
