## Helm Basic Interview Question and Answers:

1. **What is Helm?**  
   Helm is a Kubernetes package manager that simplifies application deployment and management using charts.

2. **What is a Helm Chart?**  
   A Helm Chart is a collection of files that define Kubernetes resources and configurations for deploying applications.

3. **What are the main components of a Helm Chart?**  
   The main components of a Helm chart are `Chart.yaml`, `values.yaml`, `templates/`, and `charts/` directories.

4. **What is `values.yaml` in Helm?**  
   `values.yaml` contains default configuration values for a Helm chart that can be overridden during deployment.

5. **What is a `release` in Helm?**  
   A `release` is an instance of a Helm chart deployed to a Kubernetes cluster with a specific configuration.

6. **What is the purpose of `Chart.yaml`?**  
   `Chart.yaml` contains metadata about the Helm chart, including its name, version, and description.

7. **What is the `helm install` command?**  
   `helm install` is used to deploy a Helm chart to a Kubernetes cluster, creating a release.

8. **What is the `helm upgrade` command?**  
   `helm upgrade` is used to upgrade a deployed Helm release with a new version of the chart or configuration.

9. **What is a `template` in a Helm chart?**  
   A `template` is a Kubernetes manifest file that uses Go templating to dynamically generate resource configurations.

10. **What is the `helm rollback` command?**  
    `helm rollback` reverts a Helm release to a previous version in case of issues with the current release.

11. **What is the difference between a `Chart` and a `Release`?**  
    A `Chart` is the package containing Kubernetes manifests, while a `Release` is a specific instance of a chart deployed in the cluster.

12. **What is Helm’s templating engine?**  
    Helm uses the Go templating engine to render Kubernetes manifest files dynamically based on values provided during deployment.

13. **What are Helm dependencies?**  
    Helm dependencies allow a chart to depend on other charts, making it easy to manage complex applications with multiple components.

14. **What is the purpose of `helm list`?**  
    `helm list` shows the list of deployed Helm releases in the current Kubernetes cluster.

15. **How can you pass custom values to a Helm chart during installation?**  
    You can pass custom values using `--values <file>` or `--set key=value` during the `helm install` or `helm upgrade` command.

16. **What is `helm repo`?**  
    `helm repo` is used to manage Helm chart repositories, such as adding, updating, or listing available chart repositories.

17. **What is the purpose of `helm uninstall`?**  
    `helm uninstall` is used to delete a Helm release from a Kubernetes cluster.

18. **What is the `helm template` command?**  
    `helm template` renders the Kubernetes manifests from a chart without deploying them to the cluster.

19. **What is a `subchart` in Helm?**  
    A `subchart` is a Helm chart that is included as a dependency within another chart, enabling modular applications.

20. **What is the Helm `--dry-run` flag used for?**  
    The `--dry-run` flag simulates an installation or upgrade without actually applying changes, useful for validation before deployment.
