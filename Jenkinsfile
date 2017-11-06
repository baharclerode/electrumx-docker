node("docker") {
    stage("Checkout Sources") {
        checkout scm
    }

    def revisionSha1 = sh(returnStdout: true, script: 'git ls-remote --exit-code https://github.com/kyuupichan/electrumx.git refs/heads/master | cut -f 1').trim()
    def tag = "${env.BUILD_NUMBER}-master-${revisionSha1.take(6)}"

    currentBuild.displayName = tag

    def electrumxImage = docker.build("docker.dragon.zone:10081/baharclerode/electrumx:${tag}", "--build-arg revision=${revisionSha1}")
}
