pipeline {
                                            agent any
                                            
                                            stages{
                                                stage("Code"){
                                                    steps{
                                                        echo "Cloning the code"
                                                        git url:"https://github.com/saisampathpaladi/to-do-list-cicd.git", branch: "main"
                                                    }
                                                }
                                                stage("Build"){
                                                    steps{
                                                        echo "building the code"
                                                        sh "docker build -t to-do ."
                                                    }
                                                }
                                                stage("Push to dockerhub"){
                                                    steps{
                                                        echo "pushing the code to dockerhub"
                                                        withCredentials([usernamePassword(credentialsId: 'dc', passwordVariable: 'dockerhubpass', usernameVariable: 'dockerhubusr')])
                                                        {
                                                        sh """
			                                            	docker login -u ${dockerhubusr} -p ${dockerhubpass}
			                                            	docker tag to-do ${dockerhubusr}/to-do:latest 
                                                            docker push ${dockerhubusr}/to-do:latest
                                                        """
                                                        }
                                                    }
                                                }
                                                stage("deploy"){
                                                    steps{
                                                        echo "deploying the code to agents"
                                                        sh "docker-compose down && docker-compose up -d"
                                                    }
                                                }
                                                stage("test"){
                                                    steps{
                                                        echo "testing"
                                                    }
                                                }
                                                
                                            }
                                        }
