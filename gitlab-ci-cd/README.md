# CI/CD on GitLab

## Run on specific local runner

- On the local runner (Ubuntu). cf. https://docs.gitlab.com/runner/install/linux-repository.html
    ```
    curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh" | sudo bash
    sudo apt install gitlab-runner
    sudo gitlab-runner start
    sudo gitlab-runner register --url ${URL} --token ${TOKEN} # or --registration-token
    # Important: Input tag as ${TAG} in the interactive form!
    ```

- On the gitlab server.
    - Settings > CI/CD > Runners > Specific runners. Check if the specific runner is registered.
    - CI/CD > Editor. Example .gitlab-ci.yml is:

        ```
        # Local runs on ${TAG}

        build:
          stage: build
          tags:
            - ${TAG}
          timeout: 10m
          script:
            - make
          artifacts:
            paths:
              - main

        test:
          stage: test
          timeout: 1h
          tags:
            - ${TAG}
          script:
            - bash test.sh

        deploy:
          stage: deploy
          tags:
            - ${TAG}
          script:
            - sleep 1
          environment: production
        ```
