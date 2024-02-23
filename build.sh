set -e

DOCKERPUSH=0
ARCHITECTURE=""
while [ -n "$1" ]; do 
    case "$1" in
    --dockerpush) 
        DOCKERPUSH=1 ;; 
    --arc)
        ARCHITECTURE="$2" shift;;      
    esac 
    shift
done

docker build -t shukriadams/dotnet6build .
echo "container built"

LOOKUP=$(docker run shukriadams/dotnet6build:latest bash -c "dotnet --version") 
if [ -n "${LOOKUP%%6.0.*}" ] ; then
    echo "ERROR : container returned unexpected dotnet version ${LOOKUP}, expected 6.0.*** "
    exit 1
else
    echo "container smoketest passed"
fi

if [ $DOCKERPUSH -eq 1 ]; then
    echo "starting docker push"
    TAG=$(git describe --tags --abbrev=0) 
    echo "Tag ${TAG} detected"

    docker tag shukriadams/dotnet6build:latest shukriadams/dotnet6build:"${TAG}${ARCHITECTURE}"
    docker login -u $DOCKER_USER -p $DOCKER_PASS 
    docker push shukriadams/dotnet6build:$TAG$ARCHITECTURE
fi

echo "build complete"


