# Configuring IKS cluster with Cisco Intersight Service for Terraform on vSphere Infrastructure

## Contents

      Use Cases
      Pre-requisites, Guidelines
      Create TFCB Workspaces using TFE Provider
      Provision IP Pools, Policies and IKS Cluster with TFCB
      Import the IKS Cluster kube_config into a TFCB Workspace
      Deploy IWO Performance Collector Pod using Helm
      Deploy a sample App "Hello IKS" using Helm
      Try with a Sandbox

### Use Cases

* As a Cloud Admin, Build Workspaces in TFCB to support Infrastructure as Code Provisioning.
* As a Cloud Admin, use TFCB to provision IP Pools, Kubernetes Policies, and an IKS Cluster on vSphere Infrastructure to be leveraged by DevOps Teams.
* As a Cloud Admin, use IST, ((Intersight Service for HashiCorp Terraform), to deploy IWO (Intersight Workload Optimizer) Collector to collect app and infrastructure insights.
* As an App Developer, use IST to deploy a sample "Hello IKS" Application.

![alt text](https://github.com/prathjan/images/blob/main/iksnew.png?raw=true)

### Pre-requisites, Guidelines

1. Sign up for a user account on Intersight.com. You will need Premier license as well as IWO license to complete this use case. Log in to intersight.com and generate API/Secret Keys.

2. Sign up for a TFCB (Terraform for Cloud Business) at <https://app.terraform.io/>. Log in and generate the User API Key. You will need this when you create the TF Cloud Target in Intersight.  If not a paid version, you will need to enable the trial account.

3. Clone this repository to your own VCS Repository.

4. Integrate your VCS Repository into the TFCB Orgnization following these instructions: <https://www.terraform.io/docs/cloud/vcs/index.html>.  Be sure to copy the OAth Token which you will use later on for Workspace provisioning.

5. You will need access to a vSphere infrastructure.  You will use this to install the Intersight Assist Appliance and provision the Kubernetes (IKS) Containers.

6. You will log into your Intersight account and create the following targets. Please refer to Intersight docs for details on how to create these Targets:

    Intersight Assist - This will provide on-premise proxy communication services.
    vSphere Target - Requires Intersight Assist Appliance.  
    TFC Cloud (This requires a Terraform for Cloud Business Account and at least 1 Advantage Tier License in Intersight)
    TFC Cloud Agent - After Claiming the TFCB Target, provising a Terraform Agent.  Be sure to add the following Managed Hosts/Networks:

            network for vsphere host i.e. 198.18.0.0/24
            network for Kubernetes Pod IP Range, i.e 198.18.1.0/24 (CIDR Ranges are not required)
            github-releases.githubusercontent.com
            github.com
            prathjan.github.io

7. Download this repository and create your own instance that the TFC Workspacesgit repository so the scripts c:

    sb_globalvar -> <https://github.com/CiscoDevNet/tfglobalvar.git> -> Execution mode as Remote

    sb_k8sprofile -> <https://github.com/CiscoDevNet/tfk8spolicy.git> -> Execution mode as Remote

    sb_iks -> <https://github.com/CiscoDevNet/intersight-tfb-iks.git> -> Execution mode as Remote

    sb_iksapp -> <https://github.com/CiscoDevNet/tfiksapp.git> -> Execution mode as Agent

    sb_iwocollector -> <https://github.com/CiscoDevNet/tfiwoapp.git> -> Execution mode as Agent

    sb_iksdelete -> <https://github.com/CiscoDevNet/tfiksdelete.git> -> Execute mode as Remote

6. You will open the workspace "sb_globalvar" in TFCB add the following variables based on your vSphere cluster:

    device_name = Name of the Virtual Machine Provider you wish to add. i.e vCenter

    portgroup = Name of the portgroup(s) to be used in this provider. Example: "Management"

    datastore = Name of the datastore to be used with this provider.

    vspherecluster = Name of the cluster you wish to make part of this provider within vCenter.

    resource_pool = Name of the resource pool to be used with this provider.

    organization = Intersight Organization name

    #ip_pool_policy params

    starting_address = Starting IP Address you want for this pool.

    pool_size = Number of IPs you want this pool to contain.

    netmask = Subnet Mask for this pool.

    gateway = Default gateway for this pool.

    primary_dns = Primary DNS Server for this pool.

    #instance type

    cpu = Number of CPU allocated to the virtual machine.

    disk_size = Amount of disk to be assigned to the virtual machine in GiB

    memory = Amount of memory assigned to the virtual machine in MiB.

    Please also set this workspace to share its data with other workspaces in the organization by enabling Settings->General Settings->Share State Globally.

7. You will open the workspace "sb_k8sprofile" and add the following variables:

    api_key = API key from Intersight for user

    secretkey = Secret key from Intersight for user -> mark as sensitive

    password = vSphere admin password -> mark as sensitive

8. You will open the workspace "sb_iks" and add the following variables:

    api_key = API key from Intersight for user

    secretkey = Secret key from Intersight for user -> mark as sensitive

    mgmtcfgsshkeys = SSH public key -> mark as sensitive

9. You will open the workspace "sb_iksdelete" and add the following variables:

    api_key = API key from Intersight for user

    secretkey = Secret key from Intersight for user -> mark as sensitive

    name = name of k8s cluster to delete

10. You will open the workspace "sb_globalvar" in TFCB and queue a plan manually. This will populate the global variables that will be used by the other TFCB workspaces.

11. You will execute the Runs in the workspaces in this order:

    sb_k8sprofile - See section below on "Provision IKS Policies and IP Pools with TFCB"

    sb_iks - See section below on "Provision a IKS Cluster with TFCB"

    sb_iksapp - See section below on "Deploy a sample "Hello IKS" App using Helm"

    sb_iwocollector - See section below on "Deploy IWO collector using Helm"

### Provision IKS Policies and IP Pools with TFCB

Before IKS clusters can be created, policies and IP Pools need to be setup. The workspace "sb_k8sprofile" accounts for this.
Open "sb_k8sprofile" workspace and Queue a plan manually. Check for status of Run. If successful, it should look something like this:
![alt text](https://github.com/prathjan/images/blob/main/prof.png?raw=true)

### Provision a IKS Cluster with TFCB

Once policies are configured successfully, IKS clusters can be provisioned. The workspace "sb_iks" accounts for this.
Open "sb_iks" workspace and Queue a plan manually. Check for status of Run. If successful, it should look something like this:
![alt text](https://github.com/prathjan/images/blob/main/iksout.png?raw=true)

If successful, download the cluster kubeconfig from Intersight and run a couple of kubectl commands to verify an operational cluster:

kubectl get nodes

kubectl get pods --all-namespaces

### Deploy a sample "Hello IKS" App using Helm

What use is a cluster without an App deployment,rt? The workspace "sb_iksapp" accounts for this.
Open "sb_iksapp" and Queue a plan manually.
If successful, access the app with the loadbalancer IP:

kubectl get svc --all-namespaces

Open URL in a browser window : <https://LB_IP>

You should see this:

![alt text](https://github.com/prathjan/images/blob/main/helloiks.png?raw=true)

### Deploy IWO collector using Helm

Can't have that App runing without insights,correct? The workspace "sb_iwocollector" accounts for this.
Open "sb_iwocollector" and Queue a plan manually.

Once successful, the collector is installed in your k8s cluster and requires you to claim it as target in Intersight->Target. You will use the following steps to get the Device ID and Code:

    Download kubeconfig for the sbcluster from Intersight

    Execute: kubectl <path_to_kubeconfig> port-forward <collector_pod_id> 9110

    Execute this to get the Device ID: curl -s http://localhost:9110/DeviceIdentifiers

    Execte this to get the Claim Code: curl -s http://localhost:9110/SecurityTokens

If successful, open the Optimizer in Intersight and view insights for the App just deployed:

![alt text](https://github.com/prathjan/images/blob/main/insights.png?raw=true)

### De-provisioning

You can decommision all resources provisioned by queing a destroy plan in each workspace. Please use the workspace sb_iksdelete to delete the cluster. You can delete the policies after the cluster has been deleted.

### Try with a Sandbox

A sandbox covering a lot of the above concepts can be found here:

<https://devnetsandbox.cisco.com/RM/Diagram/Index/daad55dd-45f1-46c6-a1b4-7339b318c970?diagramType=Topology>
