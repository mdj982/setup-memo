## OpenCL Settings (Intel, Linux-64bit)

### Preparation
- Access Intel website to download "Intel CPU Runtimes for OpenCL Applications" 
https://software.intel.com/content/www/us/en/develop/tools/opencl-cpu-runtime.html
- Confirm the package is put in the current directory. e.g.
    ```bash
    $ ls l_opencl_p_*.tgz
    l_opencl_p_18.1.0.015.tgz
    ```
- Confirm current OpenCL environment.
    ```bash
    $ sudo apt install -y clinfo
    $ clinfo | grep -A 3 "Number of platforms"
    Number of platforms # if not installed
    $ # after installation
    $ clinfo | grep -A 3 "Number of platforms"
    Number of platforms                               1
    Platform Name                                   Intel(R) CPU Runtime for OpenCL(TM) Applications
    Platform Vendor                                 Intel(R) Corporation
    Platform Version                                OpenCL 2.1 LINUX
    ```

#### Trouble Shootings
- Requirement for Intel account password is:
    - 8 ~ 15 characters long.
    - Contain at least one digit. ('0', ..., '9')
    - Contain at least one lower-case Latin ('a', ..., 'z')
    - Contain at least one upper-case Latin ('A', ..., 'Z')
    - Contain at least one non alpha-numeric letter.
    - **The first character should be alpha-numeric letter.**

### Quick setting
```bash
$ tar -xf l_opencl_p_18.1.0.015.tgz
$ cd l_opencl_p_18.1.0.015
$ sudo sh install.sh
# install begin: e.g.
5 (Installation)
q (pager)
accept
2 (I do NOT consent to the collection of my Information)
1 (Accept configuration and begin installation [ default ])
# install end
$ clinfo | grep -A 3 "Number of platforms"
Number of platforms                               1
Platform Name                                   Intel(R) CPU Runtime for OpenCL(TM) Applications
Platform Vendor                                 Intel(R) Corporation
Platform Version                                OpenCL 2.1 LINUX
$ ls /usr/include/CL/
cl_d3d10.h  cl_dx9_media_sharing.h ...
```