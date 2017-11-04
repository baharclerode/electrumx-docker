node("docker") {
    stage("Checkout Sources") {
        checkout scm
        sh "git submodule init"
        sh "git submodule update"
    }

    def electrumxHash = sh(returnStdout: true, script: 'cd electrumx && git rev-parse HEAD').trim()

    currentBuild.displayName = "${env.BUILD_VERSION}-master-${electrumxHash.take(6)}"

    def electrumxImage = docker.build("docker.dragon.zone:10081/baharclerode/electrumx:${env.BUILD_VERSION}-master-${electrumxHash.take(6)}")

    electrumxImage.push()
}
