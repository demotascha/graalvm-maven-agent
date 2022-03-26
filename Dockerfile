FROM jenkins/inbound-agent:alpine as jnlp

FROM ghcr.io/graalvm/native-image:ol8-java11-22.0.0.2

RUN microdnf --enablerepo ol8_codeready_builder install -y maven \
    && rm -rf /var/cache/yum

COPY --from=jnlp /usr/local/bin/jenkins-agent /usr/local/bin/jenkins-agent
COPY --from=jnlp /usr/share/jenkins/agent.jar /usr/share/jenkins/agent.jar

ENTRYPOINT ["/usr/local/bin/jenkins-agent"]
