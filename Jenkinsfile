node {
    def jenkins

    docker.withRegistry('https://hub.warecorp.com', 'wc-hub') {

    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */

        checkout scm
    }

    stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */

    jenkins = docker.build("hub.warecorp.com/jenkins/jenkins", ".")

    }

    stage('Push image') {
        /* Finally, we'll push the image with two tags:
         * First, the incremental build number from Jenkins
         * Second, the 'latest' tag.
         * Pushing multiple tags is cheap, as all the layers are reused. */
        docker.withRegistry('https://hub.warecorp.com/jenkins/jenkins', 'wc-hub') {
            jenkins.push("${env.BUILD_NUMBER}")
            jenkins.push("latest")
        }
    }
  }
}