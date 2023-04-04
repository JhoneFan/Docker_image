# Docker_image
Docker image environment for StyleGAN2-ada-pytorch  
This Docker image is on nvidia/cuda:11.2.0-cudnn8-devel-ubuntu18.04 with TensorFlow==1.14.0, python==3.7 and pytorch==1.7.1 and jupyter  
Be careful with nvidia/cuda:11.2.0-cudnn8-devel-ubuntu18.04, since the StyleGAN2-ada-pytorch need to use nvcc, we can not use the runtime, e.g. nvidia/cuda:11.2.0-cudnn8-runtime-ubuntu18.04  
After install this you can !pip install ninja  
Here is an example to deploy your environment  
I make it in Windows OS, step 1: install docker desktop, and open it  
Step 2: in the command prompt, create a folder: mkdir my-docker-project; cd cd my-docker-project; generate empty file: type nul > Dockerfile (you can use the Dockerfile example)  
Step 3: docker build -t stylegan2:v1 ./  
Step 4-0: I use RISE ICE service (you can use other cloud service), need to login the Harbor of RICE ICE, and find the credential, login the command prompt
Step 4: docker tag stylegan2:v2 registry.ice.ri.se/stylegan2/stylegan2:v1  
Step 5: docker push registry.ice.ri.se/stylegan2/stylegan2:v1  
Step 6: can use your own image in Rancher and launch the Jupyter notebook  



