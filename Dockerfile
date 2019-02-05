FROM google/cloud-sdk

COPY run-builder.bash /bin
CMD ["bash", "-xe", "/bin/run-builder.bash"]
