node("docker") {
    stage("Checkout Sources") {
        checkout scm
    }
    
    def image

    stage("Build Docker Image") {

        def revisionSha1 = sh(returnStdout: true, script: 'git ls-remote --exit-code https://github.com/kyuupichan/electrumx.git refs/heads/master | cut -f 1').trim()
        def tag = "${env.BRANCH_NAME}-${env.BUILD_NUMBER}-${revisionSha1.take(6)}"

        currentBuild.displayName = tag
        
        docker.withRegistry('https://docker.dragon.zone:10080', 'jenkins-nexus') {
            image = docker.build("baharclerode/electrumx:${tag}", "--build-arg revision=${revisionSha1} .")
        }
    }
    
    stage("Push Docker Image") {
        docker.withRegistry('https://docker.dragon.zone:10081', 'jenkins-nexus') {
            image.push()
            image.push(env.BRANCH_NAME)
        }
    }
}
