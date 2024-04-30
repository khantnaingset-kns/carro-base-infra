variables {
    environment = "dev"
    project_name = "carro"
    vpc_name = "main-vpc"
}

run "test" {
    command = plan

    assert {
        condition = module.vpc.vpc_name == "dev-carro-main-vpc"
        error_message = "VPC name did not match expected"
    }
}