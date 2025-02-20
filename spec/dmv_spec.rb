require 'spec_helper'

RSpec.describe Dmv do
  describe '#initialize' do
    it 'can initialize' do
      expect(@dmv).to be_an_instance_of(Dmv)
      expect(@dmv.facilities).to eq([])
    end
  end

  describe '#add facilities' do
    it "can create facility instances" do 
      @dmv.add_facility({})
      expect(@dmv.facilities[0]).to be_an_instance_of(Facility) 
    end 

    it 'created instances are stored in an array' do
      @dmv.add_facility({})
      @dmv.add_facility({})
      expect(@dmv.facilities).to be_an(Array)
      expect(@dmv.facilities.count).to eq(2)
    end
  end

  describe '#facilities_offering_service' do
    it "can add services to a facility" do 
      @dmv.add_facility({})
      @dmv.facilities[0].add_service('Road Test')
      expect(@dmv.facilities[0].services).to eq(['Road Test'])
    end

    it 'can return list of facilities offering a specified Service' do
      @dmv.add_facility({})
      @dmv.add_facility({})
      facility_0 = @dmv.facilities[0]
      facility_1 = @dmv.facilities[1]
      facility_0.add_service("Road Test")
      facility_1.add_service("Road Test")
      expect(@dmv.facilities_offering_service('Road Test')).to eq([facility_0, facility_1])
    end

    it "can create facility instances from imported API data" do 
      or_dmv_office_locations = DmvDataService.new.or_dmv_office_locations
      new_york_facilities = DmvDataService.new.ny_dmv_office_locations
      @dmv.add_facility(or_dmv_office_locations)
      @dmv.add_facility(new_york_facilities)
      expect(@dmv.facilities.count).to eq(231)
    end 
  end 

  describe 'data formatting' do
    before(:each) do 
      or_dmv_office_locations = DmvDataService.new.or_dmv_office_locations
      new_york_facilities = DmvDataService.new.ny_dmv_office_locations
      missouri_facilities = DmvDataService.new.mo_dmv_office_locations
      @dmv.add_facility(or_dmv_office_locations)
      @dmv.add_facility(new_york_facilities)
      @dmv.add_facility(missouri_facilities)
    end 
      it "can organize name data" do 
        expect(@dmv.facilities[0].name).to eq("Albany DMV Office")
        expect(@dmv.facilities[59].name).to eq("JAMAICA KIOSK")
        expect(@dmv.facilities[231].name).to eq("OAKVILLE")
      end 

      it "can organize addresses" do
        expect(@dmv.facilities[0].address).to eq("2242 Santiam Hwy SE")
        expect(@dmv.facilities[59].address).to eq("168-46 91ST AVE., 2ND FLR")
        expect(@dmv.facilities[231].address).to eq("3164 TELEGRAPH ROAD")
      end 

      it "can pull phone numbers" do 
        expect(@dmv.facilities[0].phone).to eq("541-967-2014")
        expect(@dmv.facilities[59].phone).to eq(nil)
        expect(@dmv.facilities[60].phone).to eq("5857531604")
        expect(@dmv.facilities[231].phone).to eq("(314) 887-1050")
      end 

      it "can format zip codes" do 
        expect(@dmv.facilities[0].zip).to eq("97321")
        expect(@dmv.facilities[59].zip).to eq("11432")
        expect(@dmv.facilities[231].zip).to eq("63125")
      end 

      it "can list facility type" do 
        expect(@dmv.facilities[0].type).to eq("DMV Location")
        expect(@dmv.facilities[59].type).to eq("DISTRICT OFFICE")
        expect(@dmv.facilities[231].type).to eq("1MV")
      end 

      it "can list website if available" do 
        expect(@dmv.facilities[0].website).to eq("http://www.oregon.gov/ODOT/DMV/pages/offices/albany.aspx")
        expect(@dmv.facilities[60].website).to eq(nil)
        expect(@dmv.facilities[231].website).to eq(nil)
        expect(@dmv.facilities[237].website).to eq("losllc.com")
      end 

      it "can list city" do 
        expect(@dmv.facilities[0].city).to eq("Albany")
        expect(@dmv.facilities[59].city).to eq("JAMAICA")
        expect(@dmv.facilities[231].city).to eq("ST LOUIS")
      end 
      
      it "can list state" do 
        expect(@dmv.facilities[0].state).to eq("OR")
        expect(@dmv.facilities[59].state).to eq("NY")
        expect(@dmv.facilities[231].state).to eq("MO")
      end 
    end
end
