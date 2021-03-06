require 'spec_helper'

describe 'ipa', :type => :class do
  describe "on RedHat platform" do
    let(:facts) { { :osfamily => 'RedHat',
        :ipa_adminhomedir => '/ipa/home',
        :ipa_replicascheme => '',
        :ipa_adminuidnumber => 450,
        :ipaddress => '123.456.678.001',
        :lsbdistdescription => ''
      } }

    context 'with master => true' do
      describe "ipa" do
        let(:params) {
          {
            :master  => true,
            :cleanup => false,
            :adminpw => '12345678',
            :dspw    => '12345678',
            :domain  => 'test.domain.org',
            :realm   => 'TEST.DOMAIN.ORG'
          }
        }
        it { should contain_class('ipa::master') }
        it { should contain_package('ipa-server') }
      end
    end
  end

  describe "on Debian platform" do
    let(:facts) { { :osfamily => 'Debian',
        :ipa_adminhomedir => '/ipa/home',
        :ipa_replicascheme => '',
        :ipa_adminuidnumber => 450,
        :ipaddress => '123.456.678.001',
        :lsbdistdescription => '',
        :manufacturer => ''
      } }

    context 'with client => true' do
      describe "ipa" do
        let(:params) {
          {
            :master  => false,
            :client  => true,
            :domain  => 'test.domain.org',
            :realm   => 'TEST.DOMAIN.ORG',
            :otp     => '12345678'
          }
        }
        it { should contain_class('ipa::client') }
        it { should contain_package('freeipa-client') }
      end
    end
  end
end
